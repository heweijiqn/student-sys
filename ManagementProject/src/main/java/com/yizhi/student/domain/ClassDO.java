package com.yizhi.student.domain;

import java.io.Serializable;
import java.util.Date;



/**
 * 班级表
 * 
 * @author dunhf
 * @email 499345515@qq.com
 * @date 2019-07-29 14:20:37
 */
public class ClassDO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	//主键
	private Integer id;
	//班级编号
	private String className;
	//简称
	private String singleName;
	//所属学院
	private Integer tocollegeId;
	//所属专业
	private Integer tomajorId;
	//班级编号
	private String classNum;
	
	private String collegeName;
	
	private String majorName;

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
	 * 设置：班级编号
	 */
	public void setClassName(String className) {
		this.className = className;
	}
	/**
	 * 获取：班级编号
	 */
	public String getClassName() {
		return className;
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
	/**
	 * 设置：所属专业
	 */
	public void setTomajorId(Integer tomajorId) {
		this.tomajorId = tomajorId;
	}
	/**
	 * 获取：所属专业
	 */
	public Integer getTomajorId() {
		return tomajorId;
	}
	/**
	 * 设置：班级编号
	 */
	public void setClassNum(String classNum) {
		this.classNum = classNum;
	}
	/**
	 * 获取：班级编号
	 */
	public String getClassNum() {
		return classNum;
	}
	public String getCollegeName() {
		return collegeName;
	}
	public void setCollegeName(String collegeName) {
		this.collegeName = collegeName;
	}
	public String getMajorName() {
		return majorName;
	}
	public void setMajorName(String majorName) {
		this.majorName = majorName;
	}
}
