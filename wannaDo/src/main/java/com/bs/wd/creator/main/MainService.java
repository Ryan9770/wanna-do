package com.bs.wd.creator.main;

import java.util.List;
import java.util.Map;

import com.bs.wd.creator.courseManage.Course;

public interface MainService {
	public List<Course> listCourse(Map<String, Object> map);
}
