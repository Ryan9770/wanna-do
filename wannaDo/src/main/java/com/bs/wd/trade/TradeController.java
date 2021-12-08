package com.bs.wd.trade;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("trade.tradeController")
@RequestMapping("/trade/*")
public class TradeController {
	@RequestMapping(value="list")
	public String list() {
		return ".trade.list";
	}
}
