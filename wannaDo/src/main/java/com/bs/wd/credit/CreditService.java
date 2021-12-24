package com.bs.wd.credit;

import java.util.List;
import java.util.Map;

public interface CreditService {
	public void insertCredit(Credit dto) throws Exception;
	public int dataCount(Map<String, Object> map);
	public List<Credit> listCredit(Map<String, Object> map);
	public int myCookie(String userId);
	public String buyDate(String userId);
	public void refundRequest(Credit dto) throws Exception;
	public void creditStateUpdate(int num) throws Exception;
}
