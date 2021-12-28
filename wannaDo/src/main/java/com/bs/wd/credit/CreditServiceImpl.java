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

	@Override
	public String buyDate(String userId) {
		String result = null;
		try {
			result = dao.selectOne("credit.buyDate", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void refundRequest(Credit dto) throws Exception {
		try {
			dao.selectOne("credit.refundRequest", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void creditStateUpdate(int num) throws Exception {
		try {
			dao.selectOne("credit.creditStateUpdate", num);
		} catch (Exception e) {
		}
	}

	@Override
	public List<Credit> listUse(Map<String, Object> map) {
		List<Credit> list = null;
		try {
			list = dao.selectList("credit.listUse", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int useCookie(String userId) {
		int result = 0;
		try {
			result = dao.selectOne("credit.useCookie", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int useCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("credit.useCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public String useDate(String userId) {
		String result = null;
		try {
			result = dao.selectOne("credit.useDate", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}	
}
