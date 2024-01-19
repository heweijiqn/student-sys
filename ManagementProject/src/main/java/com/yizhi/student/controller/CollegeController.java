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

import com.yizhi.student.domain.CollegeDO;
import com.yizhi.student.service.CollegeService;
import com.yizhi.common.utils.PageUtils;
import com.yizhi.common.utils.Query;
import com.yizhi.common.utils.R;

/**
 * 学院（部或系）表
 * 
 * @author dunhf
 * @email 499345515@qq.com
 * @date 2019-07-26 14:33:37
 */
 
@Controller
@RequestMapping("/student/college")
public class CollegeController {
	@Autowired
	private CollegeService collegeService;
	
	@GetMapping()
	@RequiresPermissions("student:college:college")
	String College(){
	    return "student/college/college";
	}
	
	@ResponseBody
	@GetMapping("/list")
	@RequiresPermissions("student:college:college")
	public PageUtils list(@RequestParam Map<String, Object> params){
		//查询列表数据
		if (params.get("sort")!=null) {
			params.put("sort",BeanHump.camelToUnderline(params.get("sort").toString()));
		}
		//查询列表数据
        Query query = new Query(params);
		List<CollegeDO> collegeList = collegeService.list(query);
		int total = collegeService.count(query);
		PageUtils pageUtils = new PageUtils(collegeList, total,query.getCurrPage(),query.getPageSize());
		return pageUtils;
	}
	
	@GetMapping("/add")
	@RequiresPermissions("student:college:add")
	String add(){
	    return "student/college/add";
	}

	@GetMapping("/edit/{id}")
	@RequiresPermissions("student:college:edit")
	String edit(@PathVariable("id") Integer id,Model model){
		CollegeDO college = collegeService.get(id);
		model.addAttribute("college", college);
	    return "student/college/edit";
	}
	
	/**
	 * 保存
	 */
	@Log("学院（部或系）表保存")
	@ResponseBody
	@PostMapping("/save")
	@RequiresPermissions("student:college:add")
	public R save( CollegeDO college){
		if(collegeService.save(college)>0){
			return R.ok();
		}
		return R.error();
	}
	/**
	 * 修改
	 */
	@Log("学院（部或系）表修改")
	@ResponseBody
	@PostMapping("/update")
	@RequiresPermissions("student:college:edit")
	public R update( CollegeDO college){
		collegeService.update(college);
		return R.ok();
	}
	
	/**
	 * 删除
	 */
	@Log("学院（部或系）表删除")
	@PostMapping( "/remove")
	@ResponseBody
	@RequiresPermissions("student:college:remove")
	public R remove( Integer id){
		if(collegeService.remove(id)>0){
		return R.ok();
		}
		return R.error();
	}
	
	/**
	 * 删除
	 */
	@Log("学院（部或系）表批量删除")
	@PostMapping( "/batchRemove")
	@ResponseBody
	@RequiresPermissions("student:college:batchRemove")
	public R remove(@RequestParam("ids[]") Integer[] ids){
		collegeService.batchRemove(ids);
		return R.ok();
	}
	
}
