package com.bs.wd.admin.contactManage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bs.wd.common.MyUtil;


@Controller("admin.contactManage.contactManageController")
@RequestMapping("/admin/contactManage/*")
public class ContactManageController {	
	
	@Autowired
	private ContactManageService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping("list")
	public String listContact(
			@RequestParam(value="page", defaultValue="1") int current_page,
			HttpServletRequest req,
			Model model
			) throws Exception{
		
		String cp = req.getContextPath();
		
		int rows = 10;
		int total_page = 0;
		int dataCount =0;
		
		   // 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
      
        
        dataCount = service.dataCount();
       if(dataCount != 0) {
    	   total_page = myUtil.pageCount(rows, dataCount);
       }
       
       if(total_page < current_page) {
           current_page = total_page;
       }
       
        Map<String, Object> map = new HashMap<String, Object>();
        // 리스트에 출력할 데이터를 가져오기
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Contact> list = service.listContact(map);
		
		int listNum, n =0;
		for(Contact dto : list) {
			listNum = dataCount - (start + n -1);
			dto.setListNum(listNum);
			n++;
		}
		
		String listUrl = cp+"/admin/contactManage/list";
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
		
		return ".admin.contactManage.list";
	}
	
	@RequestMapping("updateState")
	public String updateState(Contact dto, int contactIdx,String page) throws Exception{
		
		try {
			service.updateState(contactIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/admin/contactManage/list";
	}
}
