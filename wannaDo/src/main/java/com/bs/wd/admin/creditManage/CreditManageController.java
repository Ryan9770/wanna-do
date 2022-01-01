package com.bs.wd.admin.creditManage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bs.wd.common.MyUtil;

@Controller("admin.creditManage.creditManageController")
@RequestMapping("/admin/creditManage/*")
public class CreditManageController {
	
	@Autowired
	private CreditManageService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping("list")
	public String listBuy(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			HttpServletRequest req,
			Model model	
			) throws Exception{
		
		String cp = req.getContextPath();
		
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		dataCount = service.buyDataCount();
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
		
		List<MyWallet> list = service.listBuy(map);
		
		int listNum, n = 0;
		for(MyWallet dto : list) {
			listNum = dataCount - (start + n -1);
			dto.setListNum(listNum);
			n++;
		}
		
		String listUrl = cp + "/admin/creditManage/list";
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        
		return ".admin.creditManage.listBuy";
	}
	
	@RequestMapping("listRefund")
	public String listRefund(@RequestParam(value = "page", defaultValue = "1") int current_page,
			HttpServletRequest req,
			Model model	
			) throws Exception{
		
		String cp = req.getContextPath();
		
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		dataCount = service.refundDataCount();
		if(dataCount !=0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		
		if(total_page < current_page) {
			current_page = total_page;
		}
		
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		
		List<RefundCookie> list = service.listRefund(map);
		
		int listNum,n = 0;
		for(RefundCookie dto : list) {
			listNum = dataCount - (start + n -1);
			dto.setListNum(listNum);
			n++;
		}

		String listUrl = cp + "/admin/creditManage/listRefund";
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        
		return ".admin.creditManage.listRefund";
	}
	
	@RequestMapping("refundList")
	@ResponseBody
	public Map<String, Object> refundList() throws Exception{
   	    
		Map<String, Object> map = new HashMap<String, Object>();
		int rows = 5;

		int start = 1;
		int end = rows;
		map.put("start", start);
		map.put("end", end);
		
		List<RefundCookie> listRefund = service.listRefund(map);
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("listRefund", listRefund);
		
		return model;
	}
	
	@RequestMapping(value = "listBuySection",produces="application/json; charset=utf-8")
	@ResponseBody
	public String listBuySection() throws Exception{
		JSONArray jarr = new JSONArray();
		JSONObject job;
		
		List<Analysis> listBuy = service.listBuySection();
		
		for(int i=0; i<listBuy.size(); i++) {
			job = new JSONObject();
			job.put("name", listBuy.get(i).getSection().toString());
			job.put("value", listBuy.get(i).getPrice());
			jarr.put(job);
		}

		return jarr.toString();
	}
}
