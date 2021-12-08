package com.bs.wd.study;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("study.studyController")
@RequestMapping("/study/*")
public class StudyController {
	@RequestMapping(value="list")
	public String list() {
		return ".study.list";
	}
}
