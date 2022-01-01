package com.bs.wd.creator.courseManage;

import java.util.List;
import java.util.Map;

public interface CourseManageService {
	public int dataCount(Map<String, Object> map);
	
	public List<Course> listCourse(Map<String, Object>map);
	public List<Course> listCategory(Map<String, Object> map);
	public List<Course> listCourseState(int num);
	public List<Course> listChapter(int courseNum);
	
	public Course readCourse(int num);
	public Course readCourseState(int num);
	
	public void updateCourseEnabled(Map<String, Object> map) throws Exception;

	public void insertCourse(Course dto, String pathname) throws Exception;
	public void updateCourse(Course dto, String pathname) throws Exception;
	public void deleteCourse(Map<String, Object> map) throws Exception;
	
	public void insertCategory(Course dto) throws Exception;
	public void updateCategory(Course dto) throws Exception;
	public void deleteCategory(int categoryNum) throws Exception;
	
}
