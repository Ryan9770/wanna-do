package com.bs.wd.creator.withdraw;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bs.wd.common.dao.CommonDAO;

@Service("creator.withdraw.withdrawService")
public class WithdrawServiceImpl implements WithdrawService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Withdraw> listWithdraw(Map<String, Object> map) {
		List<Withdraw> list = null;
		
		try {
			list = dao.selectList("credit.listWithdraw", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(String userId) {
		int result = 0;
		try {
			result = dao.selectOne("credit.dataCountWithcount", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
