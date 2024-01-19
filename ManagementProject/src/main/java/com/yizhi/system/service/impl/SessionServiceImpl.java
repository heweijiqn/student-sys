package com.yizhi.system.service.impl;

import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.SessionDAO;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.support.DefaultSubjectContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yizhi.common.domain.WeixinUserPrincipal;
import com.yizhi.common.utils.AddressUtils;
import com.yizhi.system.domain.UserDO;
import com.yizhi.system.domain.UserOnline;
import com.yizhi.system.domain.UserToken;
import com.yizhi.system.service.SessionService;

import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * 待完善
 *
 * @author yizhi
 */
@Service
public class SessionServiceImpl implements SessionService {
    private final SessionDAO sessionDAO;

    @Autowired
    public SessionServiceImpl(SessionDAO sessionDAO) {
        this.sessionDAO = sessionDAO;
    }

    @Override
    public List<UserOnline> list() {
        List<UserOnline> list = new ArrayList<>();
        AddressUtils addressUtils = new AddressUtils();  
        Collection<Session> sessions = sessionDAO.getActiveSessions();
        for (Session session : sessions) {
            UserOnline userOnline = new UserOnline();
            if (session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY) == null) {
                continue;
            } else {
                SimplePrincipalCollection principalCollection = (SimplePrincipalCollection) session
                        .getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY);
                Object PrimaryPrincipal=principalCollection.getPrimaryPrincipal();
                if (PrimaryPrincipal instanceof WeixinUserPrincipal) {
                	continue;
				}
                UserDO userDO = (UserDO) PrimaryPrincipal;
                userOnline.setUsername(userDO.getUsername());
            }
            userOnline.setId((String) session.getId());
            userOnline.setHost(session.getHost());
            userOnline.setStartTimestamp(session.getStartTimestamp());
            userOnline.setLastAccessTime(session.getLastAccessTime());
            userOnline.setTimeout(session.getTimeout());
            String address = ""; 
            try {  
            	   address = addressUtils.getAddresses2("ip="+session.getHost(), "GBK");  
            	  } catch (Exception e) {  
            	  }  
            userOnline.setSystemHost(address);
            list.add(userOnline);
        }
        return list;
    }

    @Override
    public List<UserDO> listOnlineUser() {
        List<UserDO> list = new ArrayList<>();
        UserDO userDO;
        Collection<Session> sessions = sessionDAO.getActiveSessions();
        for (Session session : sessions) {
            SimplePrincipalCollection principalCollection = new SimplePrincipalCollection();
            if (session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY) == null) {
                continue;
            } else {
                principalCollection = (SimplePrincipalCollection) session
                        .getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY);
                Object PrimaryPrincipal=principalCollection.getPrimaryPrincipal();
                if (PrimaryPrincipal instanceof WeixinUserPrincipal) {
                	continue;
				}
                userDO = (UserDO) PrimaryPrincipal;
                list.add(userDO);
            }
        }
        return list;
    }

    @Override
    public Collection<Session> sessionList() {
        return sessionDAO.getActiveSessions();
    }

    @Override
    public boolean forceLogout(String sessionId) {
        Session session = sessionDAO.readSession(sessionId);
        session.setTimeout(0);
        sessionDAO.delete(session);
        return true;
    }
}
