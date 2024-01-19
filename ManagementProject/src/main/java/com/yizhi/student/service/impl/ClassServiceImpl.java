package com.yizhi.student.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.yizhi.student.dao.ClassDao;
import com.yizhi.student.domain.ClassDO;
import com.yizhi.student.service.ClassService;



@Service
public class ClassServiceImpl implements ClassService {
	@Autowired
	private ClassDao classDao;
	
	@Override
	public ClassDO get(Integer id){
		return classDao.get(id);
	}
	
	@Override
	public List<ClassDO> list(Map<String, Object> map){
		return classDao.list(map);
	}
	
	@Override
	public int count(Map<String, Object> map){
		return classDao.count(map);
	}
	
	@Override
	public int save(ClassDO classt){
		return classDao.save(classt);
	}
	
	@Override
	public int update(ClassDO classt){
		return classDao.update(classt);
	}
	
	@Override
	public int remove(Integer id){
		return classDao.remove(id);
	}
	
	@Override
	public int batchRemove(Integer[] ids){
		return classDao.batchRemove(ids);
	}
	
}
