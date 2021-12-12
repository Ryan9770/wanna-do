package com.bs.wd.member;

import org.springframework.web.multipart.MultipartFile;

public class Member {
	private long memberIdx;
	private int membership;
	private String userId;
	private String userName;
	private String userPwd;
	private String register_date;
	private String modify_date;
	private String last_login;
	private String email;
	private String email1;
	private String email2;
	private String tel;
	private String tel1;
	private String tel2;
	private String tel3;
	private String birth;
	private int enabled;
	
	private String creatorName;
	private long creatorIdx;
	private String intro;
	private String imageFilename;
	private MultipartFile selectFile;
	private String creatorEmail;
	private String creatorEmail1;
	private String creatorEmail2;
	private String creatorTel;
	private String creatorTel1;
	private String creatorTel2;
	private String creatorTel3;
	public long getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(long memberIdx) {
		this.memberIdx = memberIdx;
	}
	public int getMembership() {
		return membership;
	}
	public void setMembership(int membership) {
		this.membership = membership;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getRegister_date() {
		return register_date;
	}
	public void setRegister_date(String register_date) {
		this.register_date = register_date;
	}
	public String getModify_date() {
		return modify_date;
	}
	public void setModify_date(String modify_date) {
		this.modify_date = modify_date;
	}
	public String getLast_login() {
		return last_login;
	}
	public void setLast_login(String last_login) {
		this.last_login = last_login;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getEmail1() {
		return email1;
	}
	public void setEmail1(String email1) {
		this.email1 = email1;
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getTel1() {
		return tel1;
	}
	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}
	public String getTel2() {
		return tel2;
	}
	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}
	public String getTel3() {
		return tel3;
	}
	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public int getEnabled() {
		return enabled;
	}
	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}
	public String getCreatorName() {
		return creatorName;
	}
	public void setCreatorName(String creatorName) {
		this.creatorName = creatorName;
	}
	public long getCreatorIdx() {
		return creatorIdx;
	}
	public void setCreatorIdx(long creatorIdx) {
		this.creatorIdx = creatorIdx;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
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
	public String getCreatorEmail() {
		return creatorEmail;
	}
	public void setCreatorEmail(String creatorEmail) {
		this.creatorEmail = creatorEmail;
	}
	public String getCreatorEmail1() {
		return creatorEmail1;
	}
	public void setCreatorEmail1(String creatorEmail1) {
		this.creatorEmail1 = creatorEmail1;
	}
	public String getCreatorEmail2() {
		return creatorEmail2;
	}
	public void setCreatorEmail2(String creatorEmail2) {
		this.creatorEmail2 = creatorEmail2;
	}
	public String getCreatorTel() {
		return creatorTel;
	}
	public void setCreatorTel(String creatorTel) {
		this.creatorTel = creatorTel;
	}
	public String getCreatorTel1() {
		return creatorTel1;
	}
	public void setCreatorTel1(String creatorTel1) {
		this.creatorTel1 = creatorTel1;
	}
	public String getCreatorTel2() {
		return creatorTel2;
	}
	public void setCreatorTel2(String creatorTel2) {
		this.creatorTel2 = creatorTel2;
	}
	public String getCreatorTel3() {
		return creatorTel3;
	}
	public void setCreatorTel3(String creatorTel3) {
		this.creatorTel3 = creatorTel3;
	}
	

}
