package com.yizhi.student.dao;

import com.yizhi.student.domain.MajorDO;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

/**
 * 专业名称表
 * @author dunhf
 * @email 499345515@qq.com
 * @date 2019-07-29 09:06:39
 */
@Mapper
public interface MajorDao {

	MajorDO get(Integer id);
	
	List<MajorDO> list(Map<String,Object> map);
	
	int count(Map<String,Object> map);
	
	int save(MajorDO major);
	
	int update(MajorDO major);
	
	int remove(Integer id);
	
	int batchRemove(Integer[] ids);
}
