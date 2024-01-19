package com.yizhi.system.service;

import java.util.List;
import java.util.Map;

import com.yizhi.common.domain.Tree;
import com.yizhi.system.domain.DeptDO;

/**
 * 部门管理
 * 
 * @author chglee
 * @email 1992lcg@163.com
 * @date 2017-09-27 14:28:36
 */
public interface DeptService {
	
	DeptDO get(Long deptId);
	
	List<DeptDO> list(Map<String, Object> map);
	
	int count(Map<String, Object> map);
	
	int save(DeptDO sysDept);
	
	int update(DeptDO sysDept);
	
	int remove(Long deptId);
	
	int batchRemove(Long[] deptIds);

	Tree<DeptDO> getTree(Map<String, Object> map);
	
	boolean checkDeptHasUser(Long deptId);
	
	List<Long> listChildrenIds(Long parentId);
}
