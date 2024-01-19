package com.yizhi.student.domain;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;



/**
 * 生基础信息表
 * 
 * @author dunhf
 * @email 499345515@qq.com
 * @date 2019-08-01 09:45:46
 */
public class StudentInfoDO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	//主键
	private Integer id;
	//学号
	private String studentId;
	//考生号
	private String examId;
	//所属班级
	private Integer classId;
	//学生姓名
	private String studentName;
	//身份证号
	private String certify;
	//家庭住址
	private String mailAddress;
	//外语语种
	private String foreignLanaguage;
	//性别
	private String studentSex;
	//民族
	private String nation;
	//政治面貌
	private String political;
	//一卡通卡号
	private String cardId;
	//手机号
	private String telephone;
	//科类
	private Integer subjectType;
	//所属学院
	private Integer tocollege;
	//隶属校区*****
	private Integer tocampus;
	//所属专业
	private Integer tomajor;
	//生源地
	private String birthplace;
	//隶属层次
	private String grade;
	//在校状态
	private Integer isstate;
	//出生日期
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date birthday;
	//备注
	private String note;
	//添加时间
	private Date addTime;
	//添加人
	private Integer addUserid;
	//修改时间
	private Date editTime;
	//修改人
	private Integer editUserid;

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
	 * 设置：学号
	 */
	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}
	/**
	 * 获取：学号
	 */
	public String getStudentId() {
		return studentId;
	}
	/**
	 * 设置：考生号
	 */
	public void setExamId(String examId) {
		this.examId = examId;
	}
	/**
	 * 获取：考生号
	 */
	public String getExamId() {
		return examId;
	}
	/**
	 * 设置：所属班级
	 */
	public void setClassId(Integer classId) {
		this.classId = classId;
	}
	/**
	 * 获取：所属班级
	 */
	public Integer getClassId() {
		return classId;
	}
	/**
	 * 设置：学生姓名
	 */
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	/**
	 * 获取：学生姓名
	 */
	public String getStudentName() {
		return studentName;
	}
	/**
	 * 设置：身份证号
	 */
	public void setCertify(String certify) {
		this.certify = certify;
	}
	/**
	 * 获取：身份证号
	 */
	public String getCertify() {
		return certify;
	}
	/**
	 * 设置：家庭住址
	 */
	public void setMailAddress(String mailAddress) {
		this.mailAddress = mailAddress;
	}
	/**
	 * 获取：家庭住址
	 */
	public String getMailAddress() {
		return mailAddress;
	}
	/**
	 * 设置：外语语种
	 */
	public void setForeignLanaguage(String foreignLanaguage) {
		this.foreignLanaguage = foreignLanaguage;
	}
	/**
	 * 获取：外语语种
	 */
	public String getForeignLanaguage() {
		return foreignLanaguage;
	}
	/**
	 * 设置：性别
	 */
	public void setStudentSex(String studentSex) {
		this.studentSex = studentSex;
	}
	/**
	 * 获取：性别
	 */
	public String getStudentSex() {
		return studentSex;
	}
	/**
	 * 设置：民族
	 */
	public void setNation(String nation) {
		this.nation = nation;
	}
	/**
	 * 获取：民族
	 */
	public String getNation() {
		return nation;
	}
	/**
	 * 设置：政治面貌
	 */
	public void setPolitical(String political) {
		this.political = political;
	}
	/**
	 * 获取：政治面貌
	 */
	public String getPolitical() {
		return political;
	}
	/**
	 * 设置：一卡通卡号
	 */
	public void setCardId(String cardId) {
		this.cardId = cardId;
	}
	/**
	 * 获取：一卡通卡号
	 */
	public String getCardId() {
		return cardId;
	}
	/**
	 * 设置：手机号
	 */
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	/**
	 * 获取：手机号
	 */
	public String getTelephone() {
		return telephone;
	}
	/**
	 * 设置：科类
	 */
	public void setSubjectType(Integer subjectType) {
		this.subjectType = subjectType;
	}
	/**
	 * 获取：科类
	 */
	public Integer getSubjectType() {
		return subjectType;
	}
	/**
	 * 设置：所属学院
	 */
	public void setTocollege(Integer tocollege) {
		this.tocollege = tocollege;
	}
	/**
	 * 获取：所属学院
	 */
	public Integer getTocollege() {
		return tocollege;
	}
	/**
	 * 设置：隶属校区
	 */
	public void setTocampus(Integer tocampus) {
		this.tocampus = tocampus;
	}
	/**
	 * 获取：隶属校区
	 */
	public Integer getTocampus() {
		return tocampus;
	}
	/**
	 * 设置：所属专业
	 */
	public void setTomajor(Integer tomajor) {
		this.tomajor = tomajor;
	}
	/**
	 * 获取：所属专业
	 */
	public Integer getTomajor() {
		return tomajor;
	}
	/**
	 * 设置：生源地
	 */
	public void setBirthplace(String birthplace) {
		this.birthplace = birthplace;
	}
	/**
	 * 获取：生源地
	 */
	public String getBirthplace() {
		return birthplace;
	}
	/**
	 * 设置：隶属层次
	 */
	public void setGrade(String grade) {
		this.grade = grade;
	}
	/**
	 * 获取：隶属层次
	 */
	public String getGrade() {
		return grade;
	}
	/**
	 * 设置：在校状态
	 */
	public void setIsstate(Integer isstate) {
		this.isstate = isstate;
	}
	/**
	 * 获取：在校状态
	 */
	public Integer getIsstate() {
		return isstate;
	}
	/**
	 * 设置：出生日期
	 */
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	/**
	 * 获取：出生日期
	 */
	public Date getBirthday() {
		return birthday;
	}
	/**
	 * 设置：备注
	 */
	public void setNote(String note) {
		this.note = note;
	}
	/**
	 * 获取：备注
	 */
	public String getNote() {
		return note;
	}
	/**
	 * 设置：添加时间
	 */
	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}
	/**
	 * 获取：添加时间
	 */
	public Date getAddTime() {
		return addTime;
	}
	/**
	 * 设置：添加人
	 */
	public void setAddUserid(Integer addUserid) {
		this.addUserid = addUserid;
	}
	/**
	 * 获取：添加人
	 */
	public Integer getAddUserid() {
		return addUserid;
	}
	/**
	 * 设置：修改时间
	 */
	public void setEditTime(Date editTime) {
		this.editTime = editTime;
	}
	/**
	 * 获取：修改时间
	 */
	public Date getEditTime() {
		return editTime;
	}
	/**
	 * 设置：修改人
	 */
	public void setEditUserid(Integer editUserid) {
		this.editUserid = editUserid;
	}
	/**
	 * 获取：修改人
	 */
	public Integer getEditUserid() {
		return editUserid;
	}

	@Override
	public String toString() {
		return "StudentInfoDO{" +
				"id=" + id +
				", studentId='" + studentId + '\'' +
				", examId='" + examId + '\'' +
				", classId=" + classId +
				", studentName='" + studentName + '\'' +
				", certify='" + certify + '\'' +
				", mailAddress='" + mailAddress + '\'' +
				", foreignLanaguage='" + foreignLanaguage + '\'' +
				", studentSex='" + studentSex + '\'' +
				", nation='" + nation + '\'' +
				", political='" + political + '\'' +
				", cardId='" + cardId + '\'' +
				", telephone='" + telephone + '\'' +
				", subjectType=" + subjectType +
				", tocollege=" + tocollege +
				", tocampus=" + tocampus +
				", tomajor=" + tomajor +
				", birthplace='" + birthplace + '\'' +
				", grade='" + grade + '\'' +
				", isstate=" + isstate +
				", birthday=" + birthday +
				", note='" + note + '\'' +
				", addTime=" + addTime +
				", addUserid=" + addUserid +
				", editTime=" + editTime +
				", editUserid=" + editUserid +
				'}';
	}
}
