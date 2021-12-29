package com.bs.wd.admin.creditManage;

import java.util.List;
import java.util.Map;



public interface CreditManageService {
	public int buyDataCount();
	public List<MyWallet> listBuy(Map<String, Object> map);
	
	public int refundDataCount();
	public List<RefundCookie> listRefund(Map<String, Object> map);
	public List<Analysis> listBuySection();
}
