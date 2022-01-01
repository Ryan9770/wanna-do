package com.bs.wd.creator.main;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bs.wd.creator.courseManage.Course;
import com.bs.wd.member.Member;
import com.bs.wd.member.MemberService;
import com.bs.wd.member.SessionInfo;

@Controller("creator.mainController")
public class MainController {
	@Autowired
	private MainService service;
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value="/creator")
	public String method(Model model, HttpSession session) throws ParseException{
	    
	  SessionInfo info = (SessionInfo) session.getAttribute("member");
	  Map<String, Object> map = new HashMap<String, Object>();
	  map.put("userId", info.getUserId());
	  
	  List<Course> list = service.listCourse(map);
	  String name = info.getUserId();
	  
	  int avgRate = Math.round(service.avgRate(name));
	  
	  Calendar getToday = Calendar.getInstance();
	  getToday.setTime(new Date());
	  
	  String day = memberService.readCreatorDate(name);
	  Date date = new SimpleDateFormat("yyyy-MM-dd").parse(day);
	  Calendar cmpDate = Calendar.getInstance();
	  cmpDate.setTime(date);
	  long diffSec = (getToday.getTimeInMillis() - cmpDate.getTimeInMillis()) / 1000;
	  long diffDays = diffSec / (24*60*60); //일자수 차이
	  
	  int myCookie = service.myCookie(name);
			
      model.addAttribute("list", list);
      model.addAttribute("name", name);
      model.addAttribute("avgRate", avgRate);
      model.addAttribute("day", diffDays);
      model.addAttribute("cookie", myCookie);
  
      return ".creatorLayout";
	}

	@RequestMapping(value="/creator/main/complete")
	public String complete() {
		return ".creator.main.complete";
	}

	@RequestMapping(value="")
	public String aboutAccount(HttpSession session) {	      
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", info.getUserId());

		// mywallet
		return "";
	}
}
