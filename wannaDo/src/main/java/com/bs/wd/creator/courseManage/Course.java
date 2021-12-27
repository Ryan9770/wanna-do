package com.bs.wd.creator.courseManage;

import org.springframework.web.multipart.MultipartFile;

public class Course {
	private int listNum;
	
	private int num;
	private String category;
	private String courseName;
	private String courseLevel;
	private String content;
	private String price;
	private String reg_date; // 강좌 등록일
	
	private String tag;
	private String recommended;
	private String state;
	private String userId;
	private int enabled;
	
	private String memo;
	private String creg_date;
	private String countStudent;
	private String sReg_date;	// 승인 일
	private int stateNum;
	private int stateCode;

	private String imageFile;
    private String imageFilename;
	private MultipartFile selectFile;
	
	public String getCourseLevel() {
		return courseLevel;
	}
	public void setCourseLevel(String courseLevel) {
		this.courseLevel = courseLevel;
	}
	public String getImageFilename() {
		return imageFilename;
	}
	public void setImageFilename(String imageFilename) {
		this.imageFilename = imageFilename;
	}
	public MultipartFile getSelectFile() {
		return selectFile;
	}
	public void setSelectFile(MultipartFile selectFile) {
		this.selectFile = selectFile;
	}
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public String getRecommended() {
		return recommended;
	}
	public void setRecommended(String recommended) {
		this.recommended = recommended;
	}
	public String getImageFile() {
		return imageFile;
	}
	public void setImageFile(String imageFile) {
		this.imageFile = imageFile;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getEnabled() {
		return enabled;
	}
	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getsReg_date() {
		return sReg_date;
	}
	public void setsReg_date(String sReg_date) {
		this.sReg_date = sReg_date;
	}
	public int getStateNum() {
		return stateNum;
	}
	public void setStateNum(int stateNum) {
		this.stateNum = stateNum;
	}
	public int getStateCode() {
		return stateCode;
	}
	public void setStateCode(int stateCode) {
		this.stateCode = stateCode;
	}
	public String getCountStudent() {
		return countStudent;
	}
	public void setCountStudent(String countStudent) {
		this.countStudent = countStudent;
	}
	public String getCreg_date() {
		return creg_date;
	}
	public void setCreg_date(String creg_date) {
		this.creg_date = creg_date;
	}


	
}
