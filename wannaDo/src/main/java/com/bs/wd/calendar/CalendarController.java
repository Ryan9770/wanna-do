package com.bs.wd.calendar;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("calendar.calendarController")
@RequestMapping("/calendar/*")
public class CalendarController {
	@RequestMapping(value="list")
	public String list() {
		return ".calendar.list";
	}
}
