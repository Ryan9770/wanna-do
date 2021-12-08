package com.bs.wd.about;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("about.aboutController")
public class AboutController {
	@RequestMapping(value="about", method=RequestMethod.GET)
	public String method() { 
		return ".about.main";
	}
}
