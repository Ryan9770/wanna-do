package com.bs.wd.creator.memberManage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bs.wd.common.MyUtil;
import com.bs.wd.creator.courseManage.Course;
import com.bs.wd.creator.main.MainService;
import com.bs.wd.member.SessionInfo;

@Controller("creator.memberManage.memberManageController")
@RequestMapping("/creator/memberManage/*")
public class MemberManageController {
	@Autowired
	private MainService mainService;
	
	@Autowired
	private MemberManageService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping("list")
	public String memberManage(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			HttpServletRequest req,
			@RequestParam(defaultValue="") String courseName,
			Model model, HttpSession session) throws Exception{
		
		String cp = req.getContextPath();
		
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		map.put("userId", info.getUserId());
		map.put("courseName",courseName);
		
		dataCount = service.dataCount(map);
		if(dataCount !=0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		
		if(total_page < current_page) {
			total_page = current_page;
		}
		
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Member> list = service.listMember(map);
		
        int listNum, n = 0;

        for(Member dto : list) {
        	listNum = dataCount - (start + n - 1);
            dto.setListNum(listNum);
            n++;
        }
		
        String query = "";
        String listUrl = cp+"/creator/memberManage/list";
		
		if(courseName.length()!=0) {
			if(query.length()!=0) {
				query = query + "&courseName="+courseName;
			} else {
				query = "courseName="+courseName;
			}
		}
		
		if(query.length()!=0) {
			listUrl = listUrl + "?" + query;
		}
		
        String paging = myUtil.paging(current_page, total_page, listUrl);        

        Map<String, Object> map2 = new HashMap<String, Object>();
        map2.put("userId", info.getUserId());
        List<Course> listMyCourse = mainService.listCourse(map2);
        
        model.addAttribute("list", list);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        model.addAttribute("page", current_page);
        model.addAttribute("listMyCourse", listMyCourse);
        
		return ".creator.memberManage.list";
	}
}
