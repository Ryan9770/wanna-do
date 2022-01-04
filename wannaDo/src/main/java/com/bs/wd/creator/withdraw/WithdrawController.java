package com.bs.wd.creator.withdraw;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bs.wd.common.MyUtil;
import com.bs.wd.member.SessionInfo;

@Controller("creator.withdraw.withdrawController")
public class WithdrawController {
	@Autowired
	private WithdrawService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping("/creator/withdraw/list")
	public String method(@RequestParam(value = "page", defaultValue = "1") int current_page,
			HttpServletRequest req, Model model, HttpSession session) throws Exception{

		String cp = req.getContextPath();

		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String userId = info.getUserId();
		
		dataCount = service.dataCount(userId);
		
		if(dataCount !=0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}

		if(total_page < current_page) {
			total_page = current_page;
		}
		
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		map.put("userId", userId);
		
		List<Withdraw> list = service.listWithdraw(map);
		int amount = 0;
		for(Withdraw dto : list) {
			amount = dto.getAmount();
			dto.setAmount(amount);
			dto.setPrice(amount*90);
		}
        String listUrl = cp+"/creator/withdraw/list";
        
        String paging = myUtil.paging(current_page, total_page, listUrl);        
 
        model.addAttribute("list", list);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        model.addAttribute("page", current_page);
        
		return ".creator.withdraw.list";
	}
}
