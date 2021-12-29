package com.bs.wd.admin.courseManage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bs.wd.common.dao.CommonDAO;
import com.bs.wd.course.Chapter;

@Service("admin.courseManage.courseManageService")
public class CourseManageServiceImpl implements CourseManageService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result = dao.selectOne("courseManage.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public List<Course> listCourse(Map<String, Object> map) {
		List<Course> list = null;
		try {
			list = dao.selectList("courseManage.listCourse",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Course readCourse(int num) {
		Course dto = null;
		try {
			dto = dao.selectOne("courseManage.readCourse", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateCourseEnabled(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("courseManage.updateCourseEnabled", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void insertCourseState(Course dto) throws Exception {
		try {
			dao.updateData("courseManage.insertCourseState", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Course> listCourseState(int num) {
		List<Course> list = null;
		
		try {
			list = dao.selectList("courseManage.listCourseState",num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Course readCourseState(int num) {
		Course dto = null;
		
		try {
			dto = dao.selectOne("courseManage.readCourseState", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int todayCount() {
		int result =0;
		try {
			result = dao.selectOne("courseManage.todayCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int totalCount() {
		int result =0;
		try {
			result = dao.selectOne("courseManage.totalCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	
	@Override
	public List<Course> listChapter(int num) {
		List<Course> list = null;
		
		try {
			list = dao.selectList("courseManage.listChapter", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<Analysis> listCourseSection() {
		List<Analysis> list = null;
		
		try {
			list = dao.selectList("courseManage.listCourseSection");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

}
