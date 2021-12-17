package com.bs.wd.myAccount;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bs.wd.member.Member;
import com.bs.wd.member.MemberService;
import com.bs.wd.member.SessionInfo;

@Controller("myAccount.myAccountController")
@RequestMapping("/myAccount/*")
public class MyAccountController {
	@Autowired
	private MemberService service;
	
	@RequestMapping(value="list")
	public String list(Model model, HttpSession session) {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		Member dto = service.readMember(info.getUserId());
		
		if(dto == null) {
			session.invalidate();
			return "redirect:/";
		}
		
		if(dto.getBirth()!=null) {
			String[] s = dto.getBirth().split("-");
			dto.setBirth(s[0]+"년 "+s[1]+"월 "+s[2]+"일");
		}

		model.addAttribute("dto", dto);
		
		return ".myAccount.list";
	}
}
