package com.bs.wd;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bs.wd.common.dao.CommonDAO;
import com.bs.wd.course.Course;

@Service(".home.homeService")
public class HomeServiceImpl implements HomeService {

	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Course> listCourse() {
		List<Course> list = null;
		try {
			list = dao.selectList("home.listCourse");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
