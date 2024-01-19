package com.yizhi.system.controller;

import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.yizhi.common.annotation.Log;
import com.yizhi.common.controller.BaseController;
import com.yizhi.common.domain.FileDO;
import com.yizhi.common.domain.Tree;
import com.yizhi.common.service.FileService;
import com.yizhi.common.utils.MD5Utils;
import com.yizhi.common.utils.R;
import com.yizhi.common.utils.ShiroUtils;
import com.yizhi.system.domain.MenuDO;
import com.yizhi.system.service.MenuService;
import com.yizhi.system.shiro.CustomizedToken;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class LoginController extends BaseController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	MenuService menuService;
	@Autowired
	FileService fileService;
	@Autowired
	DefaultKaptcha defaultKaptcha;

	
	@GetMapping({ "/", "" })
	String welcome(Model model) {
		return "redirect:/index";
	}

	//@Log("请求访问主页")
	@GetMapping({ "/index" })
	String index(Model model) {
		List<Tree<MenuDO>> menus = menuService.listMenuTree(getUserId());
		model.addAttribute("menus", menus);
		model.addAttribute("name", getUser().getName());
		FileDO fileDO = fileService.get(getUser().getPicId());
		if(fileDO!=null&&fileDO.getUrl()!=null){
			if(fileService.isExist(fileDO.getUrl())){
				model.addAttribute("picUrl",fileDO.getUrl());
			}else {
				model.addAttribute("picUrl","/img/photo_s.jpg");
			}
		}else {
			model.addAttribute("picUrl","/img/photo_s.jpg");
		}
		model.addAttribute("username", getUser().getUsername());
		model.addAttribute("userid", getUser().getUserId());
		return "index_v1";
	}

	@GetMapping("/login")
	String login() {
		return "login";
	}

	@Log("登录")
	@PostMapping("/login")
	@ResponseBody
	R ajaxLogin(HttpServletRequest httpServletRequest,String username, String password, String code) {
		String captchaId = (String) httpServletRequest.getSession().getAttribute("vrifyCode");
        /*关闭验证码验证
		if(code==null || captchaId==null||!code.toUpperCase().equals(captchaId.toUpperCase())){
			return R.error("验证码错误");
		}*/
		password = MD5Utils.encrypt(username, password);
		CustomizedToken token = new CustomizedToken(username,password);
		Subject subject = SecurityUtils.getSubject();
		try {
			subject.login(token);
			return R.ok();
		} catch (AuthenticationException e) {
			//清空验证码 防止爆破
			httpServletRequest.getSession().setAttribute("vrifyCode", "");
			return R.error(e.getMessage());
		}
	}

	@GetMapping("/logout")
	String logout() {
		ShiroUtils.logout();
		return "redirect:/login";
	}

	@GetMapping("/main")
	String main() {
		return "main";
	}

	@GetMapping("/403")
	String error403() {
		return "403";
	}
	
	@RequestMapping("/defaultKaptcha")
	@ResponseBody
	public void defaultKaptcha(HttpServletRequest httpServletRequest,HttpServletResponse httpServletResponse) throws Exception{
		
		httpServletResponse.reset();
		httpServletResponse.setDateHeader("Expires", 0);
		httpServletResponse.setHeader("Cache-Control","no-store, no-cache, must-revalidate");
		httpServletResponse.addHeader("Cache-Control", "post-check=0, pre-check=0");
		httpServletResponse.setHeader("Pragma", "no-cache");
		httpServletResponse.setContentType("image/jpeg");
 
		String createText = defaultKaptcha.createText();
		httpServletRequest.getSession().setAttribute("vrifyCode", createText);
		
 
		BufferedImage bi = defaultKaptcha.createImage(createText);
		ServletOutputStream out = httpServletResponse.getOutputStream();
		ImageIO.write(bi, "jpg", out);
		try {
			out.flush();
		} finally {
			out.close();
		}
		
	}


}
