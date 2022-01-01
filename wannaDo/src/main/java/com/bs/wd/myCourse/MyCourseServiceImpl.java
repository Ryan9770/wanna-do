package com.bs.wd.myCourse;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bs.wd.common.dao.CommonDAO;

@Service(".myCourse.myCourseService")
public class MyCourseServiceImpl implements MyCourseService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<MyCourse> listLike(Map<String, Object> map) {
		
		List<MyCourse> list = null;
		
		try {
			list = dao.selectList("myCourse.listLike",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<MyCourse> listMyCourse(Map<String, Object> map) {
		
		List<MyCourse> list = null;
		
		try {
			list = dao.selectList("myCourse.listMyCourse",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
