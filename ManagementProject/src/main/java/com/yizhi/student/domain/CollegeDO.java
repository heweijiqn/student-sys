package com.yizhi.student.domain;

import java.io.Serializable;
import java.util.Date;



/**
 * 学院（部或系）表
 * 
 * @author dunhf
 * @email 499345515@qq.com
 * @date 2019-07-26 14:33:37
 */
public class CollegeDO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	//主键
	private Integer id;
	//学院名称
	private String collegeName;
	//简称
	private String singleName;
	//学院介绍
	private String introduce;
	//学院编号
	private String collegeNum;

	/**
	 * 设置：主键
	 */
	public void setId(Integer id) {
		this.id = id;
	}
	/**
	 * 获取：主键
	 */
	public Integer getId() {
		return id;
	}
	/**
	 * 设置：学院名称
	 */
	public void setCollegeName(String collegeName) {
		this.collegeName = collegeName;
	}
	/**
	 * 获取：学院名称
	 */
	public String getCollegeName() {
		return collegeName;
	}
	/**
	 * 设置：简称
	 */
	public void setSingleName(String singleName) {
		this.singleName = singleName;
	}
	/**
	 * 获取：简称
	 */
	public String getSingleName() {
		return singleName;
	}
	/**
	 * 设置：学院介绍
	 */
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	/**
	 * 获取：学院介绍
	 */
	public String getIntroduce() {
		return introduce;
	}
	/**
	 * 设置：学院编号
	 */
	public void setCollegeNum(String collegeNum) {
		this.collegeNum = collegeNum;
	}
	/**
	 * 获取：学院编号
	 */
	public String getCollegeNum() {
		return collegeNum;
	}
}
