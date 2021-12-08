package com.bs.wd.course;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("course.courseController")
@RequestMapping("/course/*")
public class CourseController {
	@RequestMapping(value="list")
	public String list() {
		return ".course.list";
	}
}
