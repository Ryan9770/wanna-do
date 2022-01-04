package com.bs.wd.creator.withdraw;

import java.util.List;
import java.util.Map;

public interface WithdrawService {
	public int dataCount(String userId);
	public List<Withdraw> listWithdraw(Map<String, Object> map);
}
