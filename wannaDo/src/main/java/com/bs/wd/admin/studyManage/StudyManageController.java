package com.bs.wd.admin.studyManage;

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

import com.bs.wd.common.MyUtil;
import com.bs.wd.member.SessionInfo;





@Controller("admin.studyManage.studyManageController")
@RequestMapping("/admin/studyManage/*")
public class StudyManageController {

	@Autowired
	private StudyManageService service;
	
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

		List<Study> list = service.listStudy(map);
		
		int listNum, n = 0;
		for (Study dto : list) {
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
			n++;
		}
		
		String query = "";
		String listUrl = cp + "/admin/studyManage/list";
		if (keyword.length() != 0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}

		if (query.length() != 0) {
			listUrl = cp + "/admin/studyManage/list?" + query;

		}

		String paging = myUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);

		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);

		
		return ".admin.studyManage.list";
	}
	
	@RequestMapping(value = "detail")
	public String detail(
			@RequestParam int num,
			
			Model model
			) throws Exception{
		
		Study dto = service.readStudy(num);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		int rows = 5;
		int current_page = 1;
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
		
		for (Reply rdto : listReply) {
			dto.setContent(rdto.getContent().replaceAll("\n", "<br>"));
		}
		
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("dto",dto);
		model.addAttribute("listReply", listReply);
		model.addAttribute("replyCount", replyCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);

		return "admin/studyManage/detail";
	}
	
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	public String deleteStudy(@RequestParam int num
			,HttpSession session,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword
			) throws Exception{
		String state = "false";
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
			state = "true";
		} catch (Exception e) {
			state = "false";
		}
		
		return "redirect:/admin/studyManage/list?"+query;
	}
	
}
