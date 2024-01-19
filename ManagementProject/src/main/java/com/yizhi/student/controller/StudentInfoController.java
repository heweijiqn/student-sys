package com.yizhi.student.controller;

import com.yizhi.common.annotation.Log;
import com.yizhi.common.utils.PageUtils;
import com.yizhi.common.utils.R;
import com.yizhi.common.utils.StringUtils;
import com.yizhi.student.domain.StudentInfoDO;
import com.yizhi.student.service.StudentInfoService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 生基础信息表
 */
 
@Controller
@RequestMapping("/student/studentInfo")
public class StudentInfoController {

	


	@Autowired
	private StudentInfoService studentInfoService;
    //
	@Log("学生信息保存")
	@ResponseBody
	@PostMapping("/save")
	@RequiresPermissions("student:studentInfo:add")
	public R save(StudentInfoDO studentInfoDO){

		int save = studentInfoService.save(studentInfoDO);
		if (save > 0) {
			return R.ok();
		}else {
			return R.error("保存失败");
		}
	}

	/**
	 * 可分页 查询
	 */
	@ResponseBody
	@GetMapping("/list")
	@RequiresPermissions("student:studentInfo:studentInfo")
	public PageUtils list(@RequestParam Map<String, Object> params){

		// 获取分页参数：page、limit
		int page = Integer.parseInt(params.getOrDefault("page", "1").toString());
		int limit = Integer.parseInt(params.getOrDefault("limit", "10").toString());

		// 设置查询参数
		params.put("offset", (page - 1) * limit);
		params.put("limit", limit);



		// 调用查询方法
		List<StudentInfoDO> studentList = studentInfoService.list(params);
		int total = studentInfoService.count(params);

		return new PageUtils(studentList, total, limit, page);
	}


	/**
	 * 修改
	 */
	@Log("学生基础信息表修改")
	@ResponseBody
	@PostMapping("/update")
	@RequiresPermissions("student:studentInfo:edit")
	public R update(StudentInfoDO studentInfo){

		int update = studentInfoService.update(studentInfo);
		if (update > 0) {
			return R.ok();
		}else {
			return R.error("修改失败");
		}
	}

	/**
	 * 删除
	 */
	@Log("学生基础信息表删除")
	@PostMapping( "/remove")
	@ResponseBody
	@RequiresPermissions("student:studentInfo:remove")
	public R remove( Integer id){

		int remove = studentInfoService.remove(id);
		if (remove > 0) {
			return R.ok();
		}else {
			return R.error("删除失败");
		}
	}
	
	/**
	 * 批量删除
	 */
	@Log("学生基础信息表批量删除")
	@PostMapping( "/batchRemove")
	@ResponseBody
	@RequiresPermissions("student:studentInfo:batchRemove")
	public R remove(@RequestParam("ids[]") Integer[] ids){

		int batchRemove = studentInfoService.batchRemove(ids);
		if (batchRemove > 0) {
			return R.ok();
		}else {
			return R.error("批量删除失败");
		}
	}


	//前后端不分离 客户端 -> 控制器-> 定位视图
	/**
	 * 学生管理 点击Tab标签 forward页面
	 */
	@GetMapping()
	@RequiresPermissions("student:studentInfo:studentInfo")
	String StudentInfo(){
		return "student/studentInfo/studentInfo";
	}

	/**
	 * 更新功能 弹出View定位
	 */
	@GetMapping("/edit/{id}")
	@RequiresPermissions("student:studentInfo:edit")
	String edit(@PathVariable("id") Integer id,Model model){
		StudentInfoDO studentInfo = studentInfoService.get(id);
		model.addAttribute("studentInfo", studentInfo);
		return "student/studentInfo/edit";
	}

	/**
	 * 学生管理 添加学生弹出 View
	 */
	@GetMapping("/add")
	@RequiresPermissions("student:studentInfo:add")
	String add(){
	    return "student/studentInfo/add";
	}
	
}
