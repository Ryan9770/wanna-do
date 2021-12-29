package com.bs.wd.admin.creditManage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bs.wd.common.dao.CommonDAO;

@Service("admin.creditManage.creditManageService")
public class CreditManageServiceImpl implements CreditManageService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public int refundDataCount() {
		int result = 0;
		try {
			result = dao.selectOne("creditManage.refundDataCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<RefundCookie> listRefund(Map<String, Object> map) {
		List<RefundCookie> list= null;
		try {
			list = dao.selectList("creditManage.listRefund",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return list;
	}

	@Override
	public List<Analysis> listBuySection() {
		 List<Analysis> list = null;
		try {
			list = dao.selectList("creditManage.listBuySection");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	
	@Override
	public int buyDataCount() {
		int result = 0;
		try {
			result = dao.selectOne("creditManage.buyDataCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<MyWallet> listBuy(Map<String, Object> map) {
		List<MyWallet> list = null;
		
		try {
			list = dao.selectList("creditManage.listBuy", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
}
