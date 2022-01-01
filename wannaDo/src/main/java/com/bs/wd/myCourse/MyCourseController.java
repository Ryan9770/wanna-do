package com.bs.wd.myCourse;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bs.wd.common.MyUtil;
import com.bs.wd.member.SessionInfo;

@Controller("myCourse.myCourseController")
@RequestMapping("/myCourse/*")
public class MyCourseController {
	
	@Autowired
	private MyCourseService service;
	
	@Autowired
	@Qualifier("myUtilGeneral")
	private MyUtil myUtil;
	
	@RequestMapping(value="list", method=RequestMethod.GET)
	public String list(Model model, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		map.put("userId", info.getUserId());
		
		List<MyCourse> listLike = service.listLike(map);
		List<MyCourse> listMyCourse = service.listMyCourse(map);		
		
		model.addAttribute("listLike", listLike);
		model.addAttribute("listMyCourse", listMyCourse);
		
		return ".myCourse.list";
	}
}
