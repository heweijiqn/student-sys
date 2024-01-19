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

import com.yizhi.student.domain.ClassDO;
import com.yizhi.student.service.ClassService;
import com.yizhi.common.utils.PageUtils;
import com.yizhi.common.utils.Query;
import com.yizhi.common.utils.R;

/**
 * 班级表
 * 
 * @author dunhf
 * @email 499345515@qq.com
 * @date 2019-07-29 14:20:37
 */
 
@Controller
@RequestMapping("/student/class")
public class ClassController {
	@Autowired
	private ClassService classService;
	
	@GetMapping()
	@RequiresPermissions("student:class:class")
	String Class(){
	    return "student/class/class";
	}
	
	@ResponseBody
	@GetMapping("/list")
	@RequiresPermissions("student:class:class")
	public PageUtils list(@RequestParam Map<String, Object> params){
		//查询列表数据
		if (params.get("sort")!=null) {
			params.put("sort",BeanHump.camelToUnderline(params.get("sort").toString()));
		}
		//查询列表数据
        Query query = new Query(params);
		List<ClassDO> classList = classService.list(query);
		int total = classService.count(query);
		PageUtils pageUtils = new PageUtils(classList, total,query.getCurrPage(),query.getPageSize());
		return pageUtils;
	}
	
	@GetMapping("/add")
	@RequiresPermissions("student:class:add")
	String add(){
	    return "student/class/add";
	}

	@GetMapping("/edit/{id}")
	@RequiresPermissions("student:class:edit")
	String edit(@PathVariable("id") Integer id,Model model){
		ClassDO classt = classService.get(id);
		model.addAttribute("class", classt);
	    return "student/class/edit";
	}
	
	/**
	 * 保存
	 */
	@Log("班级表保存")
	@ResponseBody
	@PostMapping("/save")
	@RequiresPermissions("student:class:add")
	public R save( ClassDO classt){
		if(classService.save(classt)>0){
			return R.ok();
		}
		return R.error();
	}
	/**
	 * 修改
	 */
	@Log("班级表修改")
	@ResponseBody
	@PostMapping("/update")
	@RequiresPermissions("student:class:edit")
	public R update( ClassDO classt){
		classService.update(classt);
		return R.ok();
	}
	
	/**
	 * 删除
	 */
	@Log("班级表删除")
	@PostMapping( "/remove")
	@ResponseBody
	@RequiresPermissions("student:class:remove")
	public R remove( Integer id){
		if(classService.remove(id)>0){
		return R.ok();
		}
		return R.error();
	}
	
	/**
	 * 删除
	 */
	@Log("班级表批量删除")
	@PostMapping( "/batchRemove")
	@ResponseBody
	@RequiresPermissions("student:class:batchRemove")
	public R remove(@RequestParam("ids[]") Integer[] ids){
		classService.batchRemove(ids);
		return R.ok();
	}
	
}
