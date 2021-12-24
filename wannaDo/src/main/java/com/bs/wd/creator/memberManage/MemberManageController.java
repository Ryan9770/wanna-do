package com.bs.wd.creator.memberManage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("creator.memberManage.memberManageController")
@RequestMapping("/creator/memberManage/*")
public class MemberManageController {
	@Autowired
	private MemberManageService service;
	
	@RequestMapping("list")
	public String memberManage() throws Exception{
		return ".creator.memberManage.list";
	}
}
