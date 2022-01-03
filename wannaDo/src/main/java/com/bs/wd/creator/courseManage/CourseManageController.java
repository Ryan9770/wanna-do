package com.bs.wd.creator.courseManage;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bs.wd.common.MyUtil;
import com.bs.wd.member.SessionInfo;

@Controller("creator.courseManage.courseManageController")
@RequestMapping("/creator/courseManage")
public class CourseManageController {
	@Autowired
	private CourseManageService service;
	
	@Autowired
	@Qualifier("myUtilGeneral")
	private MyUtil myUtil;
	
	@RequestMapping("list")
	public String list(@RequestParam(value="page", defaultValue="1") int current_page,
				@RequestParam(defaultValue="") String enabled,
				HttpServletRequest req,
				Model model,
				HttpSession session) throws Exception{
		
		String cp = req.getContextPath();
		
		int rows =10;
		int total_page = 0;
		int dataCount = 0;
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("enabled",enabled);
		map.put("userId", info.getUserId());
		
		dataCount = service.dataCount(map);
		if(dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		
		if(total_page < current_page) {
			current_page = total_page;
		}
		
		int start = (current_page -1)*rows +1;
		int end = current_page*rows;
		map.put("start", start);
		map.put("end",end);
		
		List<Course> list = service.listCourse(map);
		
		int listNum =0;
		int n=0;
		for(Course dto :list) {
			listNum = dataCount - (start + n -1);
			dto.setListNum(listNum);
			n++;
		}
		
		String query = "";
		String listUrl = cp + "creator/courseManage/list";
		
		if(enabled.length()!=0) {
			if(query.length()!=0) {
				query = query + "&enabled="+enabled;
			} else {
				query = "enabled="+enabled;
			}
		}
		
		if(query.length()!=0) {
			listUrl = listUrl + "?" + query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        model.addAttribute("enabled", enabled);
        
		return ".creator.courseManage.list";
	}
	
	// modal창으로 띄우는 ajax
	@RequestMapping(value="detail")
	public String detailCourse(@RequestParam int num,
							Model model) throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		
		Course dto = service.readCourse(num);
		
		Course courseState = service.readCourseState(num);
		List<Course> listState = service.listCourseState(num);
		List<Course> listChapter = service.listChapter(num);
		
		for(int i=0; i<listChapter.size();i++) {
			String videoLink = listChapter.get(i).getVideoLink();
			if(videoLink != null) {
				if(videoLink.indexOf("=") > 0 ) {
					String Link = videoLink.substring(videoLink.indexOf("=") + 1); 
					listChapter.get(i).setVideoLink(Link);
				} else {
					String Link = videoLink.substring(videoLink.lastIndexOf("/")+1);
					listChapter.get(i).setVideoLink(Link);
				}
			}
		}	
		model.addAttribute("dto", dto);
		model.addAttribute("courseState", courseState);
		model.addAttribute("listState", listState);
		model.addAttribute("listChapter", listChapter);
		
		return "creator/courseManage/detail";
	}
	
	@RequestMapping(value="update",method = RequestMethod.POST )
	public String updateDetail(@RequestParam Map<String, Object> map,
			Model model) throws Exception{
		
		try {	
			service.updateCourseDetail(map);			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/creator/courseManage/list";
	}
	
	@RequestMapping(value="write", method = RequestMethod.GET)
	public String writeForm(Model model) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<Course> listCategory = service.listCategory(map);
		
		model.addAttribute("pageNo", "1");
		model.addAttribute("mode", "write");
		model.addAttribute("listCategory", listCategory);
		
		return ".creator.courseManage.write";
	}

	@RequestMapping(value="write", method = RequestMethod.POST)
	public String writeSubmit(Course dto, HttpSession session) throws Exception{
		String root = session.getServletContext().getRealPath("/");
		String path = root +"uploads" +File.separator+"course";
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		try {
			dto.setUserId(info.getUserId());
			service.insertCourse(dto, path);
		} catch (Exception e) {
		}
		return ".creator.courseManage.list";
	}

}
