package com.bs.wd.credit;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bs.wd.common.dao.CommonDAO;

@Service("credit.creditService")
public class CreditServiceImpl implements CreditService {
	@Autowired
	private CommonDAO dao;

	@Override
	public void insertCredit(Credit dto) throws Exception {
		try {
			int seq = dao.selectOne("credit.seq");
			dto.setNum(seq);
			dao.insertData("credit.insertCredit", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("credit.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Credit> listCredit(Map<String, Object> map) {
		List<Credit> list = null;
		try {
			list = dao.selectList("credit.listCredit", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int myCookie(String userId) {
		int result = 0;
		try {
			result = dao.selectOne("credit.myCookie", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
