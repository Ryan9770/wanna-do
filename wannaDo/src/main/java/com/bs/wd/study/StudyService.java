package com.bs.wd.study;

import java.util.List;
import java.util.Map;

public interface StudyService {
	public void insertStudy(Study dto) throws Exception;
	public List<Study> listStudy(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public void updateHitCount(int num) throws Exception;
	public Study readStudy(int num);
	public Study preReadStudy(Map<String, Object> map);
	public Study nextReadStudy(Map<String, Object> map);
	public void updateStudy(Study dto) throws Exception;
	public void deleteStudy(int num, String userId, int membership) throws Exception;
	
	public void insertReply(Reply dto) throws Exception;
	public List<Reply> listReply(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public void deleteReply(Map<String, Object> map) throws Exception;
	
	public List<Reply> listReplyAnswer(int answer);
	public int replyAnswerCount(int answer);
	
}
