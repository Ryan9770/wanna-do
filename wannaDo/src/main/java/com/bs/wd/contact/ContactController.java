package com.bs.wd.contact;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("contact.contactController")
@RequestMapping("/contact/*")
public class ContactController {
	
	@Autowired
	private ContactService service;
	
	@RequestMapping(value="write", method=RequestMethod.GET)
	public String writeForm() {
		return ".contact.write";
	}

	@RequestMapping(value="write", method=RequestMethod.POST)
	public String writeSubmit(Contact dto) {
		try {
			service.insertContact(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ".contact.write";
	}

}
