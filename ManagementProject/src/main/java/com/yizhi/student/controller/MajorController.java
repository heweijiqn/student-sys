package com.yizhi.student.controller;

import java.util.List;
import java.util.Map;

import com.yizhi.common.annotation.Log;
import com.yizhi.common.utils.BeanHump;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yizhi.student.domain.MajorDO;
import com.yizhi.student.service.MajorService;
import com.yizhi.common.utils.PageUtils;
import com.yizhi.common.utils.Query;
import com.yizhi.common.utils.R;

/**
 * 专业名称表
 * 
 * @author dunhf
 * @email 499345515@qq.com
 * @date 2019-07-29 09:06:39
 */
 
@Controller
@RequestMapping("/student/major")
public class MajorController {
	@Autowired
	private MajorService majorService;
	
	@GetMapping()
	@RequiresPermissions("student:major:major")
	String Major(){
	    return "student/major/major";
	}
	
	@ResponseBody
	@GetMapping("/list")
	@RequiresPermissions("student:major:major")
	public PageUtils list(@RequestParam Map<String, Object> params){
		//查询列表数据
		if (params.get("sort")!=null) {
			params.put("sort",BeanHump.camelToUnderline(params.get("sort").toString()));
		}
		//查询列表数据
        Query query = new Query(params);
		List<MajorDO> majorList = majorService.list(query);
		int total = majorService.count(query);
		PageUtils pageUtils = new PageUtils(majorList, total,query.getCurrPage(),query.getPageSize());
		return pageUtils;
	}
	
	@GetMapping("/add")
	@RequiresPermissions("student:major:add")
	String add(){
	    return "student/major/add";
	}

	@GetMapping("/edit/{id}")
	@RequiresPermissions("student:major:edit")
	String edit(@PathVariable("id") Integer id,Model model){
		MajorDO major = majorService.get(id);
		model.addAttribute("major", major);
	    return "student/major/edit";
	}
	
	/**
	 * 保存
	 */
	@Log("专业名称表保存")
	@ResponseBody
	@PostMapping("/save")
	@RequiresPermissions("student:major:add")
	public R save( MajorDO major){
		if(majorService.save(major)>0){
			return R.ok();
		}
		return R.error();
	}
	/**
	 * 修改
	 */
	@Log("专业名称表修改")
	@ResponseBody
	@PostMapping("/update")
	@RequiresPermissions("student:major:edit")
	public R update( MajorDO major){
		majorService.update(major);
		return R.ok();
	}
	
	/**
	 * 删除
	 */
	@Log("专业名称表删除")
	@PostMapping( "/remove")
	@ResponseBody
	@RequiresPermissions("student:major:remove")
	public R remove( Integer id){
		if(majorService.remove(id)>0){
		return R.ok();
		}
		return R.error();
	}
	
	/**
	 * 删除
	 */
	@Log("专业名称表批量删除")
	@PostMapping( "/batchRemove")
	@ResponseBody
	@RequiresPermissions("student:major:batchRemove")
	public R remove(@RequestParam("ids[]") Integer[] ids){
		majorService.batchRemove(ids);
		return R.ok();
	}
	
}
