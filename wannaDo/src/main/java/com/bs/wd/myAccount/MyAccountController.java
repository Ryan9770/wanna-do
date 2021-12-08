package com.bs.wd.myAccount;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("myAccount.myAccountController")
@RequestMapping("/myAccount/*")
public class MyAccountController {
	
	@RequestMapping(value="list")
	public String list() {
		return ".myAccount.list";
	}
}
