package com.yizhi.common.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.yizhi.common.domain.LogDO;
import com.yizhi.common.domain.PageDO;
import com.yizhi.common.utils.Query;
@Service
public interface LogService {
	PageDO<LogDO> queryList(Query query);
	int remove(Long id);
	int batchRemove(Long[] ids);
	int save(LogDO logDO);
}
