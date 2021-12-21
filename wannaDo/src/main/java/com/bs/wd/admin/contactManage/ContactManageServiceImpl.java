package com.bs.wd.admin.contactManage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bs.wd.common.dao.CommonDAO;

@Service("admin.contactManage.contactManageService")
public class ContactManageServiceImpl implements ContactManageService{
	
	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Contact> listContact(Map<String, Object> map) {
		List<Contact> list = null;
		try {
		list = dao.selectList("contactManage.listContact", map);	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount() {
		int result = 0;
		try {
			result = dao.selectOne("contactManage.dataCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public void updateState(int contactIdx) throws Exception {
		
		try {
			dao.updateData("contactManage.updateState", contactIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
