package com.yizhi.student.domain;

import java.io.Serializable;
import java.util.Date;



/**
 * 专业名称表
 * 
 * @author dunhf
 * @email 499345515@qq.com
 * @date 2019-07-29 09:06:39
 */
public class MajorDO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	//
	private Integer id;
	//专业名称
	private String majorName;
	//简称
	private String singleName;
	//专业介绍
	private String introduce;
	//专业编号
	private String majorNum;
	//所属学院
	private Integer tocollegeId;
	
	private String collegeName;

	/**
	 * 设置：
	 */
	public void setId(Integer id) {
		this.id = id;
	}
	/**
	 * 获取：
	 */
	public Integer getId() {
		return id;
	}
	/**
	 * 设置：专业名称
	 */
	public void setMajorName(String majorName) {
		this.majorName = majorName;
	}
	/**
	 * 获取：专业名称
	 */
	public String getMajorName() {
		return majorName;
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
	 * 设置：专业介绍
	 */
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	/**
	 * 获取：专业介绍
	 */
	public String getIntroduce() {
		return introduce;
	}
	/**
	 * 设置：专业编号
	 */
	public void setMajorNum(String majorNum) {
		this.majorNum = majorNum;
	}
	/**
	 * 获取：专业编号
	 */
	public String getMajorNum() {
		return majorNum;
	}
	/**
	 * 设置：所属学院
	 */
	public void setTocollegeId(Integer tocollegeId) {
		this.tocollegeId = tocollegeId;
	}
	/**
	 * 获取：所属学院
	 */
	public Integer getTocollegeId() {
		return tocollegeId;
	}
	public String getCollegeName() {
		return collegeName;
	}
	public void setCollegeName(String collegeName) {
		this.collegeName = collegeName;
	}
}
