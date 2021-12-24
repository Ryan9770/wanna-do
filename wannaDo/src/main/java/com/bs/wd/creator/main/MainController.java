package com.bs.wd.creator.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("creator.mainController")
public class MainController {
	
	@RequestMapping(value="/creator", method=RequestMethod.GET)
	public String method() {
		return ".creatorLayout";
	}

}
