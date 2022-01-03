package com.bs.wd.creator.memberManage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bs.wd.common.dao.CommonDAO;

@Service("creator.memberManage.memberManageService")
public class MemberManageServiceImpl implements MemberManageService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("creatorCourseManage.memberCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Member> listMember(Map<String, Object> map) {
		List<Member> list = null;
				
		try {
			list= dao.selectList("creatorCourseManage.listMember", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
}
