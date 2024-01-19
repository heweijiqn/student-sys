package com.yizhi.common.utils.weixin;

import com.alibaba.fastjson.JSON;
import com.yizhi.common.domain.SysException;
import com.yizhi.common.utils.HttpUtils;
import com.yizhi.miniapp.utils.JsonUtils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
 
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;
 
 
public class WxConfigUtil {
    private final static Logger log = LoggerFactory.getLogger(WxConfigUtil.class);
    private static String APPID = WxConfig.appid;
    private static String APPSECRET = WxConfig.appsecret;
    public static String APPXCXID = WxConfig.appxcxid;
    public static String APPXCXSECRET =WxConfig.appxcxsecret;
    private static String msgapi = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=";
    private static String nmsgapi = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=";
    private static String xcxnmsgapi = "https://api.weixin.qq.com/cgi-bin/message/wxopen/template/send?access_token=";
    private static String cmcapi = "https://api.weixin.qq.com/card/create?access_token=";
    public static String weixin_jssdk_ticket_url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=ACCESS_TOKEN&type=jsapi";
    //@Autowired
    //private static RedisUtils redisUtils;
    public static void main(String[] args) {
        Map news = new HashMap();
        List articles = new ArrayList();
        Map article = new HashMap();
        article.put("title", "您有新的点点消费消息");
        article.put("description", "您有新的点点消费消息");
        article.put("url", "http://app.diandiancaidan.com");
        article.put("picurl", "http://www.alumninet.net/imgs/tags/20160310041152.jpg");
        articles.add(article);
        news.put("articles", articles);
        try {
            Map data = new HashMap();
            Map val = new HashMap();
            val.put("value", "上菜了");
            val.put("color", "#173177");
            data.put("first", val);
            Map val1 = new HashMap();
            val1.put("value", "示例餐厅");
            val1.put("color", "#173177");
            data.put("storeName", val1);
            Map val2 = new HashMap();
            val2.put("value", "324234534");
            val2.put("color", "#173177");
            data.put("orderId", val2);
            Map val3 = new HashMap();
            val3.put("value", "堂食订单金额：100.00元");
            val3.put("color", "#173177");
            data.put("orderType", val3);
            Map val4 = new HashMap();
            val4.put("value", "为了保证出品新鲜美味，请您及时取餐");
            val4.put("color", "#173177");
            data.put("remark", val4);
            String template_id = "UU5SZ2nbYll-jnvnqh26XkdT-d1e7G7PvhZ1LnbIHgs";
            System.out.println("MsgUtil.main()" + sendNotice("o5NOXv3kwodBUaM3shb2GU_kLmeQ", "", data,null, template_id));
        } catch (Exception localException) {
        }
    }
 
    public static String sendText(String openid, String content) throws Exception {
        String token = getToken();
        if (token != null) {
            Map parameters = new HashMap();
            parameters.put("touser", openid);
            parameters.put("msgtype", "text");
            Map text = new HashMap();
            text.put("content", content);
            parameters.put("text", text);
            String str = HttpUtils.doPostBybody(msgapi + token, parameters);
            com.alibaba.fastjson.JSONObject json = JSON.parseObject(str);
            if (json.get("errcode").toString().equals("0")) {
                return "0";
            }
            return json.get("errmsg").toString();
        }
 
        return "token失败";
    }
 
    public static String sendUrl(String openid, Map news) throws Exception {
        String token = getToken();
        if (token != null) {
            Map parameters = new HashMap();
            parameters.put("touser", openid);
            parameters.put("msgtype", "news");
            parameters.put("news", news);
            String str = HttpUtils.doPostBybody(msgapi + token, parameters);
            com.alibaba.fastjson.JSONObject json = JSON.parseObject(str);
            if (json.get("errcode").toString().equals("0")) {
                return "0";
            }
            return json.get("errmsg").toString();
        }
 
        return "token失败";
    }
 
    public static String sendNotice(String openid, String url, Map data,Map miniprogram, String template_id) throws Exception {
        String token = getToken();
        if (token != null) {
            Map parameters = new HashMap();
            parameters.put("touser", openid);
            parameters.put("template_id", template_id);
            parameters.put("url", url);
            if (miniprogram!=null) {
            	parameters.put("miniprogram", miniprogram);
			}
            parameters.put("data", data);
            String str = HttpUtils.doPostBybody(nmsgapi + token, parameters);
            com.alibaba.fastjson.JSONObject json = JSON.parseObject(str);
            if (json.get("errcode").toString().equals("0")) {
                return "0";
            }
            return json.get("errmsg").toString();
        }
 
        return "token失败";
    }
 
    public static String sendXcxNotice(String openid, String url,String formid, Map data, String template_id) throws Exception {
        //String token = getToken();
        String token = getWXxcxtoken();
        if (token != null) {
            Map parameters = new HashMap();
            parameters.put("touser", openid);
            parameters.put("template_id", template_id);
            parameters.put("form_id", formid);
            parameters.put("page", url);
            
            parameters.put("data", data);
            String str = HttpUtils.doPostBybody(xcxnmsgapi + token, parameters);
            com.alibaba.fastjson.JSONObject json = JSON.parseObject(str);
            if (json.get("errcode").toString().equals("0")) {
                return "0";
            }
            return json.get("errmsg").toString();
        }
 
        return "token失败";
    }
 
    public static String getToken() throws Exception {
        String token = "";
        if ((token == null) || ("".equals(token))) {
            Map json = getAccessToken();
            if (json.get("access_token") != null) {//缓存token，避免重复请求
                //redisUtils.set("wxaccess_token", json.get("access_token").toString(), 5400L,TimeUnit.SECONDS);
                return json.get("access_token").toString();
            }
            log.error("获取微信token失败：" + json.get("errmsg"));
            return null;
        }
 
        return token;
    }
 
    public static Map getAccessToken() {
        StringBuilder url = new StringBuilder();
        url.append("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + APPID + "&secret="
                + APPSECRET);
        return JsonUtils.jsonToMap(HttpUtils.doGet(url.toString()));
    }
 
    public static String getWXxcxtoken() {
        String token = "";
        if ((token == null) || ("".equals(token))) {
            Map json = getXcxAccessToken();
            if (json.get("access_token") != null) {
                return json.get("access_token").toString();
            }
            log.error("获取微信token失败：" + json.get("errmsg"));
            return null;
        }
 
        return token;
    }
 
    public static Map getXcxAccessToken() {
        StringBuilder url = new StringBuilder();
        url.append("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + APPXCXID + "&secret="
                + APPXCXSECRET);
        return JsonUtils.jsonToMap(HttpUtils.doGet(url.toString()));
    }
 
    public static String getApiTicket() throws Exception {
        String token = getToken();
        StringBuilder url = new StringBuilder();
        url.append("https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=" + token + "&type=wx_card");
        return JsonUtils.jsonToMap(HttpUtils.doGet(url.toString())).get("ticket").toString();
    }
 
    public static String downloadMedia(String mediaId, String savePath) throws Exception {
        String filePath = null;
 
        String requestUrl = "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token=ACCESS_TOKEN&media_id=MEDIA_ID";
        requestUrl = requestUrl.replace("ACCESS_TOKEN", getToken()).replace("MEDIA_ID", mediaId);
        log.error(requestUrl);
        URL url = new URL(requestUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setDoInput(true);
        conn.setRequestMethod("GET");
 
        if (!savePath.endsWith("/")) {
            savePath = savePath + "/";
        }
        String fileExt = ".mp4";
 
        System.out.println("WxFileUtil.downloadMedia()" + conn.getHeaderField("Content-Type"));
        if (conn.getHeaderField("Content-Type").indexOf("mpeg") >= 0) {
            fileExt = ".mp4";
        } else if (conn.getHeaderField("Content-Type").indexOf("jpeg") >= 0) {
            fileExt = ".jpg";
        } else {
            log.error("获取素材失败" + conn.getHeaderField("Content-Type"));
            throw new SysException("获取素材失败");
        }
 
        filePath = savePath + mediaId + fileExt;
 
        BufferedInputStream bis = new BufferedInputStream(conn.getInputStream());
        FileOutputStream fos = new FileOutputStream(new File(filePath));
        byte[] buf = new byte['ᾠ'];
        int size = 0;
        while ((size = bis.read(buf)) != -1)
            fos.write(buf, 0, size);
        fos.close();
        bis.close();
 
        conn.disconnect();
        String info = String.format("下载媒体文件成功，filePath=" + filePath, new Object[0]);
        log.error(info);
        return filePath;
    }
 
    public static String createWxCard(String openid, String url, Map data, String type) throws Exception {
        String token = getToken();
        if (token != null) {
            Map parameters = new HashMap();
            Map card = new HashMap();
            if ("1".equals(type)) {
                card.put("card_type", "MEMBER_CARD");
                card.put("member_card", data);
            } else if ("2".equals(type)) {
                card.put("card_type", "GENERAL_COUPON");
                card.put("general_coupon", data);
            }
            parameters.put("card", card);
            String str = "";
            try {
                str = HttpUtils.doPostBybody(cmcapi + token, parameters);
            } catch (Exception e) {
                e.printStackTrace();
                log.error(e.getMessage());
                return "请求微信失败";
            }
            com.alibaba.fastjson.JSONObject json = JSON.parseObject(str);
            if (json.get("errcode").toString().equals("0")) {
                return str;
            }
            return json.get("errmsg").toString();
        }
 
        return "token失败";
    }
 
    public static Map createbaseinfoForMamcard(String logo_url, String brand_name, String shopkey) throws Exception {
        DecimalFormat df = new DecimalFormat("000");
        Map baseinfo = new HashMap();
        baseinfo.put("logo_url", (logo_url != null) && (!"".equals(logo_url)) ? logo_url
                : "http://mmbiz.qpic.cn/mmbiz/iaL1LJM1mF9aRKPZJkmG8xXhiaHqkKSVMMWeN3hLut7X7hicFNjakmxibMLGWpXrEXB33367o7zHN0CwngnQY7zb7g/0");
        baseinfo.put("code_type", "CODE_TYPE_TEXT");
        baseinfo.put("brand_name", brand_name);
        baseinfo.put("title", brand_name + "会员卡");
        baseinfo.put("color", "Color010");
        baseinfo.put("notice", "");
        baseinfo.put("description", "消费自动使用");
        Map sku = new HashMap();
        sku.put("quantity", Integer.valueOf(100000000));
        baseinfo.put("sku", sku);
        Map date_info = new HashMap();
        date_info.put("type", "DATE_TYPE_PERMANENT");
        baseinfo.put("date_info", date_info);
        baseinfo.put("get_limit", Integer.valueOf(1));
        baseinfo.put("use_custom_code", Boolean.valueOf(false));
        baseinfo.put("can_give_friend", Boolean.valueOf(false));
        baseinfo.put("custom_url_name", "会员详情");
        baseinfo.put("custom_url", "http://app.diandiancaidan.com/wap/cardinfo.jsp?id=" + shopkey);
 
        return baseinfo;
    }
 
    public static Map createWXMemCard() throws Exception {
        Map parameters = new HashMap();
        parameters.put("supply_bonus", Boolean.valueOf(false));
        parameters.put("supply_balance", Boolean.valueOf(true));
        parameters.put("prerogative", "点餐后自动使用");
        parameters.put("auto_activate", Boolean.valueOf(true));
 
        parameters.put("activate_url", "");
 
        return parameters;
    }
 
    public static Map createbaseinfoForGeneral(String logo_url, String brand_name, String shopkey, int startdate,
                                               int enddate, String title) throws Exception {
        DecimalFormat df = new DecimalFormat("000");
        Map baseinfo = new HashMap();
        baseinfo.put("logo_url", (logo_url != null) && (!"".equals(logo_url)) ? logo_url
                : "http://mmbiz.qpic.cn/mmbiz/iaL1LJM1mF9aRKPZJkmG8xXhiaHqkKSVMMWeN3hLut7X7hicFNjakmxibMLGWpXrEXB33367o7zHN0CwngnQY7zb7g/0");
        baseinfo.put("code_type", "CODE_TYPE_TEXT");
        baseinfo.put("brand_name", brand_name);
        baseinfo.put("title", title);
        baseinfo.put("color", "Color010");
        baseinfo.put("notice", "");
        baseinfo.put("description", "店内扫码点餐使用\n本卷最终解释权归" + brand_name + "店所有");
        Map sku = new HashMap();
        sku.put("quantity", Integer.valueOf(100));
        baseinfo.put("sku", sku);
        Map date_info = new HashMap();
        date_info.put("type", "DATE_TYPE_FIX_TIME_RANGE");
        date_info.put("begin_timestamp", Integer.valueOf(startdate));
        date_info.put("end_timestamp", Integer.valueOf(enddate));
        baseinfo.put("date_info", date_info);
        baseinfo.put("get_limit", Integer.valueOf(1));
 
        baseinfo.put("use_custom_code", Boolean.valueOf(false));
        baseinfo.put("can_share", Boolean.valueOf(false));
        baseinfo.put("can_give_friend", Boolean.valueOf(false));
 
        return baseinfo;
    }
 
    public static Map createWXGeneralcoupon(String detail) throws Exception {
        Map parameters = new HashMap();
        parameters.put("default_detail", detail);
 
        return parameters;
    }
 
    public static String getWXcardforUser(String openid, String wxcardid) throws Exception {
        Map parameters = new HashMap();
        parameters.put("openid", openid);
        parameters.put("card_id", wxcardid);
        String token = getToken();
        String url = "https://api.weixin.qq.com/card/user/getcardlist?access_token=" + token;
        String re = HttpUtils.doPost(url, JSON.toJSONString(parameters));
        return re;
    }
 
    public static String updateWXcardBalance(String code, String wxcardid, double add_balance) throws Exception {
        Map parameters = new HashMap();
        parameters.put("code", code);
        parameters.put("card_id", wxcardid);
        parameters.put("add_balance", Double.valueOf(add_balance));
        String token = getToken();
        String url = "https://api.weixin.qq.com/card/membercard/updateuser?access_token=" + token;
        String re = HttpUtils.doPost(url, JSON.toJSONString(parameters));
        return re;
    }
 
    public static String updateWXcardGeneralInfo(String wxcardid, Map general_coupon) throws Exception {
        Map parameters = new HashMap();
        parameters.put("card_id", wxcardid);
        parameters.put("general_coupon", general_coupon);
        String token = getToken();
        String url = "https://api.weixin.qq.com/card/update?access_token=" + token;
        String aa = JSON.toJSONString(parameters);
        String re = HttpUtils.doPost(url, JSON.toJSONString(parameters));
        return re;
    }
 
    public static String delWXcard(String wxcardid) throws Exception {
        Map parameters = new HashMap();
        parameters.put("card_id", wxcardid);
        String token = getToken();
        String url = "https://api.weixin.qq.com/card/delete?access_token=" + token;
        String re = HttpUtils.doPost(url, JSON.toJSONString(parameters));
        System.out.println(re);
        return re;
    }
 
    public static String sendWxcard(List<String> openids, String wxcardid) throws Exception {
        Map parameters = new HashMap();
        parameters.put("touser", openids);
        Map wxcard = new HashMap();
        wxcard.put("card_id", wxcardid);
        parameters.put("wxcard", wxcard);
        parameters.put("msgtype", "wxcard");
        String token = getToken();
        String url = "https://api.weixin.qq.com/cgi-bin/message/mass/send?access_token=" + token;
        String re = HttpUtils.doPost(url, JSON.toJSONString(parameters));
        return re;
    }
 
    public static Map getWXSessionKey(String code) {
        Map parameters = new HashMap();
        String url = "https://api.weixin.qq.com/sns/jscode2session?appid=" + APPXCXID + "&secret=" + APPXCXSECRET
                + "&js_code=" + code + "&grant_type=authorization_code";
        String re = HttpUtils.doPost(url, JSON.toJSONString(parameters));
        return JsonUtils.jsonToMap(re);
    }
 
    /**
     * 获取sessionkey
     *
     * @param code
     * @param appid
     * @param secret
     * @return "session_key":"jhNgNW+aPdMqmM1XtwFqZA==","expires_in":7200,"openid":"oCYQC0Q3-lSJ2MeAjxD7njl0E8AA"}
     */
    public static Map getWXSessionKey(String code, String appid, String secret) {
        Map parameters = new HashMap();
        String url = "https://api.weixin.qq.com/sns/jscode2session?appid=" + appid + "&secret=" + secret + "&js_code="
                + code + "&grant_type=authorization_code";
        String re = HttpUtils.doPostSSL(url,parameters,"UTF-8");
        return JsonUtils.jsonToMap(re);
    }
 
    public static String getWXxcxQrimg(String curl, String savepath) {
        Map parameters = new HashMap();
        String token = getWXxcxtoken();
        parameters.put("path", curl);
        parameters.put("width", "640");
 
        String url = "https://api.weixin.qq.com/cgi-bin/wxaapp/createwxaqrcode?access_token=" + token;
        String re = null;
        try {
            re = HttpUtils.doPostWithImg(url, JSON.toJSONString(parameters), savepath + ".jpe");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return re;
    }
}
