package com.bs.wd.credit;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("credit.creditController")
@RequestMapping("/credit/*")
public class CreditController {
	@RequestMapping(value="buy")
	public String buy() {
		return ".credit.buy";
	}
}
