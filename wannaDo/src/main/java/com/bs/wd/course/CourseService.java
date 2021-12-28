package com.bs.wd.course;

import java.util.List;
import java.util.Map;


public interface CourseService {
	public void insertCourse(Course dto, String pathname) throws Exception;
	public int dataCount(Map<String, Object> map);
	public List<Course> listCourse(Map<String, Object> map);
	public Course readCourse(int num);
	public void updateHitCount(int num) throws Exception;
	public void updateCourse(Course dto, String pathname) throws Exception;
	public void deleteCourse(Map<String, Object> map) throws Exception;
	
	public void insertCategory(Course dto) throws Exception;
	public void updateCategory(Course dto) throws Exception;
	public List<Course> listCategory(Map<String, Object> map);
	public void deleteCategory(int categoryNum) throws Exception;
	
	public void insertCourseLike(Map<String, Object> map) throws Exception;
	public void deleteCourseLike(Map<String, Object> map) throws Exception;
	public int courseLikeCount(int num);
	public boolean userCourseLiked(Map<String, Object> map);
	
	public void insertChapter(Chapter dto) throws Exception;
	public List<Chapter> listChapter(Map<String, Object> map);
	public void updateChapter(Chapter dto) throws Exception;
	public void deleteChapter(Map<String, Object> map) throws Exception;
	
	public void insertVideo(Chapter dto) throws Exception;
	public List<Chapter> listVideo(int chapNum);
	
	
	public void insertReview(Review dto) throws Exception;
	public int reviewCount(Map<String, Object> map);
	public List<Review> listReview(Map<String, Object> map);
	public void deleteReview(Map<String, Object> map) throws Exception;
	
	public void buyCourse(Course dto) throws Exception;

}
