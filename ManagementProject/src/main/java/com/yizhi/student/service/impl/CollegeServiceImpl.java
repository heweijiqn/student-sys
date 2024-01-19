package com.yizhi.student.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.yizhi.student.dao.CollegeDao;
import com.yizhi.student.domain.CollegeDO;
import com.yizhi.student.service.CollegeService;



@Service
public class CollegeServiceImpl implements CollegeService {
	@Autowired
	private CollegeDao collegeDao;
	
	@Override
	public CollegeDO get(Integer id){
		return collegeDao.get(id);
	}
	
	@Override
	public List<CollegeDO> list(Map<String, Object> map){
		return collegeDao.list(map);
	}
	
	@Override
	public int count(Map<String, Object> map){
		return collegeDao.count(map);
	}
	
	@Override
	public int save(CollegeDO college){
		return collegeDao.save(college);
	}
	
	@Override
	public int update(CollegeDO college){
		return collegeDao.update(college);
	}
	
	@Override
	public int remove(Integer id){
		return collegeDao.remove(id);
	}
	
	@Override
	public int batchRemove(Integer[] ids){
		return collegeDao.batchRemove(ids);
	}
	
}
