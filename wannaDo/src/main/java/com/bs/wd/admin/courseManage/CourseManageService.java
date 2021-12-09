package com.bs.wd.admin.courseManage;

import java.util.List;
import java.util.Map;


public interface CourseManageService {
	public int dataCount(Map<String, Object> map);
	public List<Course> listCourse(Map<String, Object> map);
	public Course readCourse(int courseNum);
	public void updateCourseEnabled(Map<String, Object> map) throws Exception;
	public void insertCourseState(Course dto) throws Exception;
	public List<Course> listCourseState(int courseNum);
	public Course readCourseState(int courseNum);
}
