package com.bs.wd.study;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bs.wd.common.dao.CommonDAO;

@Service("study.studyService")
public class StudyServiceImpl implements StudyService {

	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertStudy(Study dto) throws Exception {
		try {
			dao.insertData("study.insertStudy", dto);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public List<Study> listStudy(Map<String, Object> map) {
		List<Study> list = null;
		try {
			list = dao.selectList("study.listStudy", map);
		} catch (Exception e) {
		}		
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("study.dataCount", map);
		} catch (Exception e) {
		}
		return result;
	}
	
	
	@Override
	public void updateHitCount(int num) throws Exception{
		try {
			dao.updateData("study.updateHitCount", num);
		} catch (Exception e) {
		}
	}
		
	@Override
	public Study readStudy(int num) {
		Study dto = null;
		
		try {
			dto = dao.selectOne("study.readStudy", num);
		} catch (Exception e) {
		}
		
		return dto;
	}

	@Override
	public Study preReadStudy(Map<String, Object> map) {
		Study dto = null;
		try {
			dto = dao.selectOne("study.preReadStudy", map);
		} catch (Exception e) {
		}
		
		return dto;
	}
	
	@Override
	public Study nextReadStudy(Map<String, Object> map) {
		Study dto = null;
		try {
			dto = dao.selectOne("study.nextReadStudy", map);
		} catch (Exception e) {
		}
		
		return dto;
	}

	@Override
	public void updateStudy(Study dto) throws Exception {	
		try {
			dao.updateData("study.updateStudy", dto);	
		} catch (Exception e) {
		}
	
	}

	@Override
	public void deleteStudy(int num) throws Exception {
		try {
			Study dto = readStudy(num);
			if(dto == null) {
				return;
			}
			
			dao.deleteData("study.deleteStudy", num);
		} catch (Exception e) {
		}
	}

	@Override
	public void insertReply(Reply dto) throws Exception {
		try {
			dao.insertData("study.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list = null;
		
		try {
			list = dao.selectList("study.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("study.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("study.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Reply> listReplyAnswer(int answer) {
		List<Reply> list = null;
		
		try {
			list = dao.selectList("study.listReplyAnswer", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyAnswerCount(int answer) {
		int result = 0;
		
		try {
			result = dao.selectOne("study.replyAnswerCount", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
