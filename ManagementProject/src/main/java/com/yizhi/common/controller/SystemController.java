package com.yizhi.common.controller;

import java.util.HashMap;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yizhi.common.information.Server;
import com.yizhi.common.utils.R;

@Controller
public class SystemController {

    @GetMapping("/system/info")
    @RequiresPermissions("common:system:info")
    public String info(Model model) throws Exception {
        Server server = new Server();
        server.copyTo();
        model.addAttribute("server", server);
        return "system/info";
    }
    
    @GetMapping("/system/info/json")
    @RequiresPermissions("common:system:info")
	@ResponseBody
	public R jsonInfo() throws Exception{
    	Map<String, Object> data=new HashMap<String, Object>();
    	Server server = new Server();
        server.copyTo();
    	data.put("data",server);
		return R.ok(data);
	};
}
