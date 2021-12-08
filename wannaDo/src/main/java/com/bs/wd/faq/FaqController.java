package com.bs.wd.faq;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("faq.faqController")
public class FaqController {
	@RequestMapping(value="faq", method=RequestMethod.GET)
	public String method() {
		return ".faq.main";
	}
}
