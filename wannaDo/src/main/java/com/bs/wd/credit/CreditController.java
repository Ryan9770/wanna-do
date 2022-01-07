package com.bs.wd.credit;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bs.wd.common.MyUtil;
import com.bs.wd.member.SessionInfo;

@Controller("credit.creditController")
@RequestMapping("/credit/*")
public class CreditController {
	@Autowired
	private CreditService service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value = "main")
	public String main() throws Exception {
		return ".credit.main";
	}
	
	@RequestMapping(value="list")
	public String list(
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			HttpServletRequest req,
			HttpSession session, Model model) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", info.getUserId());
		
		dataCount = service.dataCount(map);
		if(dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		if(total_page < current_page) {
			current_page = total_page;
		}
		
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Credit> list = service.listCredit(map);
		
		Date endDate = new Date();
		long gap;
		int listNum, n = 0;
		for (Credit dto : list) {
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date beginDate = formatter.parse(dto.getBuy_date());
			gap = (endDate.getTime() - beginDate.getTime()) / (60 * 60 * 1000);
			dto.setGap(gap);

			dto.setBuy_date(dto.getBuy_date().substring(0, 10));
			
			n++;
		}
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("list", list);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "credit/list";
	}
	
	@RequestMapping(value="buy")
	public String buy() throws Exception {
		return "credit/buy";
	}
	
	@RequestMapping(value="pay", method=RequestMethod.GET)
	public String payForm(@RequestParam int amount, @RequestParam int price, Model model, HttpSession session) throws Exception {
		int orderNo = service.orderNo();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userName = info.getUserName();
		model.addAttribute("userName", userName);
		model.addAttribute("orderNo", orderNo);
		model.addAttribute("amount", amount);
		model.addAttribute("price", price);
		return ".credit.pay";
	}
	
	@RequestMapping(value = "pay", method = RequestMethod.POST)
	public String paySubmit(Credit dto, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			dto.setUserId(info.getUserId());
			service.insertCredit(dto);
		} catch (Exception e) {
		}
		return "redirect:/credit/main";
	}
	
	@RequestMapping(value = "myCookie", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> myCookie(HttpSession session) throws Exception {
		String state = "true";
		int count = 0;
		int count1 = 0;
		int count2 = 0;
		try {
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			String userId = info.getUserId();
			count1 = service.myCookie(userId);
			count2 = service.useCookie(userId);
			count = count1 - count2;
		} catch (Exception e) {
			state = "true";
		}
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		model.put("myCookie", count);
		return model;
	}
	
	@RequestMapping(value="refund", method=RequestMethod.GET)
	public String refundForm(@RequestParam int num,
			@RequestParam int amount,
			@RequestParam int price,
			HttpSession session, Model model) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		model.addAttribute("num", num);
		model.addAttribute("amount", amount);
		model.addAttribute("price", price);
		model.addAttribute("userId", info.getUserId());
		
		return ".credit.refund";
	}
	
	@RequestMapping(value="refund", method=RequestMethod.POST)
	public String refundSubmit(Credit dto, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			dto.setUserId(info.getUserId());
			service.refundRequest(dto);
			service.creditStateUpdate(dto.getNum());
			service.refundOk(dto.getNum());
		} catch (Exception e) {
		}
		return "redirect:/credit/main";
	}
	
	@RequestMapping(value="listUse")
	public String listUse(
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			HttpServletRequest req,
			HttpSession session, Model model) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		int rows = 10;
		int total_page = 0;
		int useCount = 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", info.getUserId());
		
		useCount = service.useCount(map);
		if(useCount != 0) {
			total_page = myUtil.pageCount(rows, useCount);
		}
		if(total_page < current_page) {
			current_page = total_page;
		}
		
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Credit> listUse = service.listUse(map);
		
		Date endDate = new Date();
		long gap;
		int listNum, n = 0;
		for (Credit dto : listUse) {
			listNum = useCount - (start + n - 1);
			dto.setListNum(listNum);
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date beginDate = formatter.parse(dto.getUse_date());
			gap = (endDate.getTime() - beginDate.getTime()) / (60 * 60 * 1000);
			dto.setGap(gap);

			dto.setUse_date(dto.getUse_date().substring(0, 10));
			
			n++;
		}
		String paging = myUtil.pagingMethod(current_page, total_page, "listUse");
		
		model.addAttribute("listUse", listUse);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("useCount", useCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "credit/listUse";
	}
	
	@RequestMapping(value="refundCourse", method=RequestMethod.GET)
	public String refundCourseForm(@RequestParam int courseNum,
			@RequestParam int amount,
			@RequestParam String courseName,
			HttpSession session, Model model) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		model.addAttribute("courseNum", courseNum);
		model.addAttribute("amount", amount);
		model.addAttribute("courseName", courseName);
		model.addAttribute("userId", info.getUserId());
		
		return ".credit.refundCourse";
	}
	
	@RequestMapping(value="refundCourse", method=RequestMethod.POST)
	public String refundCourseSubmit(Credit dto, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			service.refundStateUpdate(dto.getNum());
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("userId", info.getUserId());
			map.put("courseNum", dto.getCourseNum());
			service.refundCourse(map);
			service.refundCourseOk(map);
		} catch (Exception e) {
		}
		return "redirect:/credit/main";
	}
}