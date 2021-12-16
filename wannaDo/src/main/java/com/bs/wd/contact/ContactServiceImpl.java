package com.bs.wd.contact;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bs.wd.common.dao.CommonDAO;

@Service("contact.contactService")
public class ContactServiceImpl implements ContactService {
	
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertContact(Contact dto) throws Exception {
		try {
			dao.insertData("contact.insertContact", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
