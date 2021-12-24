package com.bs.wd.admin.memberManage;

import java.util.List;
import java.util.Map;

public interface MemberManageService {
	public int dataCount(Map<String, Object> map);
	
	public List<Member> listMember(Map<String, Object> map);
	public Member readMember(String userId);
	
	public int creatorCount(Map<String, Object> map);
	public List<Creator> listCreator(Map<String, Object> map);
	public Creator readCreator(String userId);
	
	public List<Analysis> listAgeSection();
	
	public void updateFailureCountReset(String userId) throws Exception;
	public void updateMemberEnabled(Map<String, Object> map) throws Exception;
	public void insertMemberState(Member dto) throws Exception;
	
	public List<Member> listMemberState(String userId);
	
	public Member readMemberState(String userId);
	public List<Member> listBirth();
	
}
