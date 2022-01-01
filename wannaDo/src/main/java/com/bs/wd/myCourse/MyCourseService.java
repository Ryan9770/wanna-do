package com.bs.wd.myCourse;

import java.util.List;
import java.util.Map;

public interface MyCourseService {
	public List<MyCourse> listLike(Map<String, Object> map);
	public List<MyCourse> listMyCourse(Map<String, Object> map);
}
