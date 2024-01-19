package com.yizhi.common.utils;

import java.io.Serializable;
import java.util.List;

/**
 */
public class PageUtils implements Serializable {
	private static final long serialVersionUID = 1L;
	// 总记录数
	private int total;
	// 列表数据
	private List<?> rows;
	
	//当前页码
	private int currPage=1;
	//总共页数
	private int totalPages = 0; //总页数
	//分页大小
	private int pageSize=10;
	//状态码
	private int code=0;

	/**
	 * 分页
	 * 
	 * @param list
	 *            列表数据
	 * @param totalCount
	 *            总记录数
	 * @param pageSize
	 *            每页记录数
	 * @param currPage
	 *            当前页数
	 */
	public PageUtils(List<?> list, int total) {
		this.rows = list;
		this.total = total;
	}
	
	public PageUtils(List<?> list, int total,int currPage,int pageSize) {
		this.rows = list;
		this.total = total;
		this.pageSize=pageSize;
		this.currPage=currPage;
		this.totalPages = (int) Math.ceil((double) total / pageSize);
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public List<?> getRows() {
		return rows;
	}

	public void setRows(List<?> rows) {
		this.rows = rows;
	}


	public int getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}

	public int getCurrPage() {
		return currPage;
	}

	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

}
