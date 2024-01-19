package com.yizhi.common.utils.weixin;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtBuilder;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.impl.compression.CompressionCodecs;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.yizhi.common.domain.TokenValidException;
import com.yizhi.common.domain.WeixinUserPrincipal;
import com.yizhi.common.utils.RandomHelper;
import com.yizhi.miniapp.config.JwtConfig;
import com.yizhi.miniapp.utils.JsonUtils;

import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;
import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Component
public class WeiXinJwtUtil {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    public static final String ROLE_REFRESH_TOKEN = "ROLE_REFRESH_TOKEN";

    private static final String CLAIM_KEY_USER_ID = "user_id";
    private static final String OPEN_ID = "openid";
    private static final String CLAIM_KEY_AUTHORITIES = "scope";
    private static final String CLAIM_KEY_ACCOUNT_ENABLED = "enabled";
    private static final String CLAIM_KEY_ACCOUNT_NON_LOCKED = "non_locked";
    private static final String CLAIM_KEY_ACCOUNT_NON_EXPIRED = "non_expired";

    private final SignatureAlgorithm SIGNATURE_ALGORITHM = SignatureAlgorithm.HS256;

    @Autowired
    private JwtConfig jwtConfig;

    public Claims parseJWT(String jsonWebToken, String base64Security){
        try{
            Claims claims = Jwts.parser()
                    .setSigningKey(DatatypeConverter.parseBase64Binary(base64Security))
                    .parseClaimsJws(jsonWebToken).getBody();
            return claims;
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return null;
    }

    public String createJWT(WeixinUserPrincipal member, String base64Security)
    {
        //生成签名密钥
        byte[] apiKeySecretBytes = DatatypeConverter.parseBase64Binary(base64Security);
        Key signingKey = new SecretKeySpec(apiKeySecretBytes, SIGNATURE_ALGORITHM.getJcaName());
        //添加构成JWT的参数
        JwtBuilder builder = Jwts.builder()
                .setId(member.getUserid())
                .setSubject(member.getUserid())
                .signWith(SIGNATURE_ALGORITHM, signingKey)
                .setExpiration(new Date(System.currentTimeMillis() + jwtConfig.getExpiration()))
                .setNotBefore(new Date(System.currentTimeMillis()));
        //生成JWT
        return builder.compact();
    }

    public String getUserIdFromToken(String token) {
        String userId;
        try {
            final Claims claims = getClaimsFromToken(token);
            userId = claims.get(CLAIM_KEY_USER_ID).toString();
        } catch (Exception e) {
            userId = "";
        }
        return userId;
    }
    public String getOpenIdFromToken(String token) {
        String userId;
        try {
            final Claims claims = getClaimsFromToken(token);
            userId = claims.get(OPEN_ID).toString();
        } catch (Exception e) {
            userId = "";
        }
        return userId;
    }
    public String getUsernameFromToken(String token) {
        String username;
        try {
            final Claims claims = getClaimsFromToken(token);
            username = claims.getSubject();
        } catch (Exception e) {
            username = null;
        }
        return username;
    }

    public Date getCreatedDateFromToken(String token) {
        Date created;
        try {
            final Claims claims = getClaimsFromToken(token);
            created = claims.getIssuedAt();
        } catch (Exception e) {
            created = null;
        }
        return created;
    }

    public Date getExpirationDateFromToken(String token) {
        Date expiration;
        try {
            final Claims claims = getClaimsFromToken(token);
            expiration = claims.getExpiration();
        } catch (Exception e) {
            expiration = null;
        }
        return expiration;
    }

    private Claims getClaimsFromToken(String token) {
        Claims claims;
        try {
            claims = Jwts.parser()
                    .setSigningKey(jwtConfig.getSecret())
                    .parseClaimsJws(token)
                    .getBody();
        } catch (Exception e) {
            claims = null;
        }
        return claims;
    }

    private Date generateExpirationDate(long expiration) {
        return new Date(System.currentTimeMillis() + expiration);
    }

    public Boolean isTokenExpired(String token) {
        final Date expiration = getExpirationDateFromToken(token);
        return expiration.before(new Date());
    }

    private Boolean isCreatedBeforeLastPasswordReset(Date created, Date lastPasswordReset) {
        return (lastPasswordReset != null && created.before(lastPasswordReset));
    }

    public String generateAccessToken(WeixinUserPrincipal member) {
        Map<String, Object> claims = generateClaims(member);
        return generateAccessToken(member.getUserid(), claims);
    }

    private Map<String, Object> generateClaims(WeixinUserPrincipal member) {
        Map<String, Object> claims = new HashMap<>();
        claims.put(CLAIM_KEY_USER_ID, member.getUserid());
        claims.put(OPEN_ID, member.getOpenId());
        claims.put(CLAIM_KEY_ACCOUNT_ENABLED, member.getDelFlag());
        claims.put(CLAIM_KEY_ACCOUNT_NON_LOCKED, false);
        claims.put(CLAIM_KEY_ACCOUNT_NON_EXPIRED, false);
        return claims;
    }

    private String generateAccessToken(String subject, Map<String, Object> claims) {
        return generateToken(subject, claims, jwtConfig.getExpiration());
    }

    public String generateRefreshToken(WeixinUserPrincipal member) {
        Map<String, Object> claims = generateClaims(member);
        // 只授于更新 token 的权限
        String roles[] = new String[]{this.ROLE_REFRESH_TOKEN};
        claims.put(CLAIM_KEY_AUTHORITIES, JsonUtils.toJson2(roles));
        return generateRefreshToken(member.getUserid(), claims);
    }

    private String generateRefreshToken(String subject, Map<String, Object> claims) {
        return generateToken(subject, claims, jwtConfig.getRefreshExpiration());
    }

    public Boolean canTokenBeRefreshed(String token, Date lastPasswordReset) {
        final Date created = getCreatedDateFromToken(token);
        return !isCreatedBeforeLastPasswordReset(created, lastPasswordReset)
                && (!isTokenExpired(token));
    }

    public String refreshToken(String token) {
        String refreshedToken;
        try {
            final Claims claims = getClaimsFromToken(token);
            refreshedToken = generateAccessToken(claims.getSubject(), claims);
        } catch (Exception e) {
            refreshedToken = null;
        }
        return refreshedToken;
    }

    private String generateToken(String subject, Map<String, Object> claims, long expiration) {
        return Jwts.builder()
                .setClaims(claims)
                .setSubject(subject)
                .setId(RandomHelper.uuid())
                .setIssuedAt(new Date())
                .setExpiration(generateExpirationDate(expiration))
                .compressWith(CompressionCodecs.DEFLATE)
                .signWith(SIGNATURE_ALGORITHM, jwtConfig.getSecret())
                .compact();
    }

    public Boolean validateToken(String token, WeixinUserPrincipal member) {
        final String userId = getUserIdFromToken(token);
        final String userName = getUsernameFromToken(token);
        // final Date created = getCreatedDateFromToken(token);
        // final Date expiration = getExpirationDateFromToken(token);
        if(userId.equals(member.getUserid())){
            if(isTokenExpired(token)){
                throw new TokenValidException("token过期");
            }
            return  true;
        }else{
            return  false;
        }

    }


}
