package com.bs.wd.contact;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("contact.contactController")
@RequestMapping("/contact/*")
public class ContactController {
	@RequestMapping(value="write")
	public String writeForm() {
		return ".contact.write";
	}
}
