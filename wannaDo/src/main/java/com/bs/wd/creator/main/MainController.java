package com.bs.wd.creator.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bs.wd.creator.courseManage.Course;
import com.bs.wd.member.SessionInfo;

@Controller("creator.mainController")
public class MainController {
	@Autowired
	private MainService service;
	
	@RequestMapping(value="/creator")
	public String method(Model model, HttpSession session) {
	    
	      SessionInfo info = (SessionInfo) session.getAttribute("member");
	      Map<String, Object> map = new HashMap<String, Object>();
	      map.put("userId", info.getUserId());
	      
	      List<Course> list = service.listCourse(map);
	      
	      model.addAttribute("list", list);
		
		return ".creatorLayout";
	}


}
