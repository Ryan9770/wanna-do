package com.bs.wd.note;

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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bs.wd.common.MyUtil;
import com.bs.wd.member.SessionInfo;

@Controller("note.noteController")
@RequestMapping("/note/*")
public class NoteController {
	@Autowired
	private NoteService service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="{menuItem}/list")
	public String list(@PathVariable String menuItem,
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			HttpSession session,
			Model model) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("userId", info.getUserId());
		
		if(menuItem.equals("receive")) {
			dataCount = service.dataCountReceive(map);
		} else {
			dataCount = service.dataCountSend(map);
		}
		
		total_page = myUtil.pageCount(rows, dataCount);
		
		if(current_page > total_page)
			current_page = total_page;
		
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Note> list = null;
		if(menuItem.equals("receive")) {
			list = service.listReceive(map);
		} else {
			list = service.listSend(map);
		}
		
		String cp = req.getContextPath();
		String query = "";
		String listUrl = cp + "/note/" + menuItem + "/list";
		String articleUrl = cp + "/note/" + menuItem + "/article?page=" + current_page;
		if(keyword.length() != 0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}
		
		if(query.length() != 0) {
			listUrl = cp + "/note/" + menuItem + "/list?" + query;
			articleUrl = cp + "/note/" + menuItem + "/article?page=" + current_page + "&" + query;	
		}
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		model.addAttribute("menuItem", menuItem);
		
		return ".note.list";
	}
	
	@GetMapping("write")
	public String writeForm(Model model) throws Exception {
		return ".note.write";
	}
	
	@PostMapping("write")
	public String writeSubmit(Note dto, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		try {
			dto.setSendId(info.getUserId());
			service.insertNote(dto);
		} catch (Exception e) {
		}
		return "redirect:/note/send/list";
	}
	
	@GetMapping(value="listFriend")
	@ResponseBody
	public Map<String, Object> listFriend(
			@RequestParam String condition,
			@RequestParam String keyword,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("userId", info.getUserId());
		List<Note> list = service.listFriend(map);
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("listFriend", list);
		return model;
	}
	
	@RequestMapping(value="{menuItem}/article")
	public String article(@PathVariable String menuItem,
			@RequestParam int noteNum,
			@RequestParam String page,
			@RequestParam(defaultValue="") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session,
			Model model) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query = "page="+page;
		if(keyword.length() != 0) {
			query += "&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("userId", info.getUserId());
		map.put("noteNum", noteNum);
		
		Note dto = null;
		Note preDto = null;
		Note nextDto = null;
		if(menuItem.equals("send")) {
			dto = service.readSend(noteNum);
			preDto = service.preReadSend(map);
			nextDto = service.nextReadSend(map);
		} else {
			service.updateReadDay(noteNum);
			dto = service.readReceive(noteNum);
			preDto = service.preReadReceive(map);
			nextDto = service.nextReadReceive(map);
		}
		if(dto == null) {
			return "redirect:/note/"+menuItem+"/list?"+query;
		}
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		model.addAttribute("dto", dto);
		model.addAttribute("preDto", preDto);
		model.addAttribute("nextDto", nextDto);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		model.addAttribute("menuItem", menuItem);
		return ".note.article";
	}
	
	@RequestMapping(value="{menuItem}/delete")
	public String delete(@PathVariable String menuItem,
			@RequestParam List<Integer> noteNumList,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session, Model model) throws Exception {
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query = "page="+page;
		if(keyword.length() != 0) {
			query += "&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		Map<String, Object> map = new HashMap<String, Object>();
		if(menuItem.equals("receive")) {
			map.put("field1", "receiveDelete");
			map.put("field2", "sendDelete");
		} else {
			map.put("field1", "sendDelete");
			map.put("field2", "receiveDelete");
		}
		map.put("noteNumList", noteNumList);
		
		try {
			service.deleteNote(map);
		} catch (Exception e) {
		}
		
		return "redirect:/note/"+menuItem+"/list?"+query;
	}
}
