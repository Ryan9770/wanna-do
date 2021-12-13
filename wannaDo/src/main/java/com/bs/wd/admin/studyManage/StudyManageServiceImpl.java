package com.bs.wd.admin.studyManage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bs.wd.common.dao.CommonDAO;

@Service("admin.studyManage.studyManageService")
public class StudyManageServiceImpl implements StudyManageService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Study> listStudy(Map<String, Object> map) {
		List<Study> list = null;
		
		try {
			list = dao.selectList("studyManage.listStudy", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("studyManage.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public Study readStudy(int num) {
		Study dto = null;
		try {
			dto = dao.selectOne("studyManage.readStudy",num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void deleteBoard(int num, int membership) throws Exception {
		try {
			Study dto = readStudy(num);
			if(dto == null || (membership < 99)) {
				return;
			}
			
			dao.deleteData("studyManage.deleteStudy",num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list = null;
		try {
			list = dao.selectList("studyManage.listReply",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("studyManage.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("studyManage.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Reply> listReplyAnswer(int answer) {
		List<Reply> list=null;
		try {
			list = dao.selectList("studyManage.listReplyAnswer",answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyAnswerCount(int answer) {
		int result = 0;
		
		try {
			result = dao.selectOne("studyManage.replyAnswerCount", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

}
