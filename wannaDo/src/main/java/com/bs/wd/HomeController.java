package com.bs.wd;

import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bs.wd.course.Course;

@Controller(".homeController")
public class HomeController {
	
	@Autowired
	private HomeService service;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
	
		List<Course> list = service.listCourse();
		
		model.addAttribute("list", list);
		
		return ".home";
	}
}
