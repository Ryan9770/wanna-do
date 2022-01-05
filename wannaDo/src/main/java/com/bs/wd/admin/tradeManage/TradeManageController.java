package com.bs.wd.admin.tradeManage;

import java.net.URLDecoder;
import java.net.URLEncoder;
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




@Controller("admin.tradeManage.tradeManageController")
@RequestMapping("/admin/tradeManage/*")
public class TradeManageController {

	@Autowired
	private TradeManageService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping("list")
	public String list(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			Model model
			) throws Exception{
		
		String cp = req.getContextPath();
		
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;

		if (req.getMethod().equalsIgnoreCase("GET")) { 
			keyword = URLDecoder.decode(keyword, "utf-8");
		}

		// 전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = service.dataCount(map);
		if (dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		

		if (total_page < current_page) {
			current_page = total_page;
		}

		
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);

		List<Trade> list = service.listTrade(map);
		
		int listNum, n = 0;
		for (Trade dto : list) {
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
			n++;
		}
		
		String query = "";
		String listUrl = cp + "/admin/tradeManage/list";
		if (keyword.length() != 0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}

		if (query.length() != 0) {
			listUrl = cp + "/admin/tradeManage/list?" + query;
		}

		String paging = myUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);

		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);

		
		return ".admin.tradeManage.list";
	}
	
	@RequestMapping(value = "detail")
	public String detail(
			@RequestParam int num,
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			Model model
			) throws Exception{
		
		Trade dto = service.readTrade(num);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		int rows = 5;
		int replyCount = service.replyCount(map);
		int total_page = myUtil.pageCount(rows, replyCount);
		if(current_page > total_page) {
			current_page = total_page;
		}
		
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Reply> listReply = service.listReply(map);
		
		for(Reply rdto : listReply) {
			dto.setContent(rdto.getContent().replaceAll("\n", "<br>"));
		}
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("dto",dto);
		model.addAttribute("listReply",listReply);
		model.addAttribute("replyCount",replyCount);
		model.addAttribute("total_page",total_page);
		model.addAttribute("page",current_page);
		model.addAttribute("paging",paging);
		
		return "admin/tradeManage/detail";
	}
	
	@RequestMapping(value = "delete", method = RequestMethod.GET)
	public String deleteTrade(@RequestParam int num
			,HttpSession session,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword
			) throws Exception{

		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		map.put("userId", info.getUserId());
		
		String query = "page="+page;
		if (keyword.length() != 0) {
			query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}
		try {
			service.deleteBoard(num, info.getMembership());
		} catch (Exception e) {
		}
		
		return "redirect:/admin/tradeManage/list?"+query;
	}
	
	@RequestMapping(value = "deleteReply", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteReply(@RequestParam Map<String, Object> map) throws Exception{
		String state = "true";
		
		try {
			service.deleteReply(map);
		} catch (Exception e) {
			state = "false";
		}
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		
		return model;
	}
	
}
