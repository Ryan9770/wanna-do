package com.bs.wd.notice;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("notice.noticeController")
@RequestMapping("/notice/*")
public class NoticeController {
	@RequestMapping(value="list")
	public String list() {
		return ".notice.list";
	}
}
