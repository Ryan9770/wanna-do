package com.bs.wd.myCourse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("myCourse.myCourseController")
@RequestMapping("/myCourse/*")
public class MyCourseController {
	
	@RequestMapping(value="list", method=RequestMethod.GET)
	public String list() {
		return ".myCourse.list";
	}
}
