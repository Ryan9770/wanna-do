package com.bs.wd.admin.studyManage;

import java.util.List;
import java.util.Map;

public interface StudyManageService {
	public List<Study> listStudy(Map<String, Object> map) ;
	public int dataCount(Map<String, Object> map);
	public Study readStudy(int num);
	public void deleteBoard(int num, int membership) throws Exception;
	
	public List<Reply> listReply(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public void deleteReply(Map<String, Object> map) throws Exception;
	

	public List<Reply> listReplyAnswer(int answer);
	public int replyAnswerCount(int answer);
}
