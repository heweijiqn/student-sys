package com.yizhi.common.utils;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * 查询参数
 */
public class Query extends LinkedHashMap<String, Object> {
	private static final long serialVersionUID = 1L;
	// 
	private int offset;
	// 每页条数
	private int limit;
	
	private int currPage=1;
	
	private int pageSize=10;
	 

	public Query(Map<String, Object> params) {
		this.putAll(params);
		// 分页参数
		if (params.get("offset")!=null&&params.get("limit")!=null) {
			this.offset = Integer.parseInt(params.get("offset").toString());
			this.limit = Integer.parseInt(params.get("limit").toString());
			this.put("offset", offset);
			this.put("page", offset / limit + 1);
			this.put("limit", limit);
		}
		if (params.get("currPage")!=null&&params.get("pageSize")!=null) {
			this.currPage= Integer.parseInt(params.get("currPage").toString());
			this.pageSize = Integer.parseInt(params.get("pageSize").toString());
			 if (currPage < 1) {
		            throw new IllegalArgumentException("currPage必须大于等于1");
		        }
		        if (pageSize < 1) {
		            throw new IllegalArgumentException("pageSize必须大于等于1");
		        }
		        offset = (int) ((currPage - 1) * pageSize);
		        this.put("offset", offset);
		        this.put("limit", pageSize);
		}
	}

	public int getOffset() {
		return offset;
	}

	public void setOffset(int offset) {
		this.put("offset", offset);
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}
	
	public int getCurrPage() {
		return currPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
}
