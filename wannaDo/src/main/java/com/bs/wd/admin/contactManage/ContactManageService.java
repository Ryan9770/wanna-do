package com.bs.wd.admin.contactManage;

import java.util.List;
import java.util.Map;

public interface ContactManageService {
	public List<Contact> listContact(Map<String, Object> map);
	public int dataCount();
	public void updateState(int contactIdx) throws Exception;
}
