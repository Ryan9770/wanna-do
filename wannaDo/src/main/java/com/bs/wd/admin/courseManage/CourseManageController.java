package com.bs.wd.admin.courseManage;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bs.wd.common.MyUtil;


@Controller("admin.courseManage.courseManageController")
@RequestMapping("/admin/courseManage/*")
public class CourseManageController {

	@Autowired
	private CourseManageService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping("list")
	public String list(	@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="") String enabled,
			HttpServletRequest req,
			Model model) throws Exception{
		
		String cp = req.getContextPath();
   	    
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
   	    
	
		
		// 전체 페이지 수/
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("enabled", enabled);


        dataCount = service.dataCount(map);
        if(dataCount != 0) {
            total_page = myUtil.pageCount(rows, dataCount) ;
        }

        // 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        if(total_page < current_page) {
            current_page = total_page;
        }

        // 리스트에 출력할 데이터를 가져오기
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);

		
		List<Course> list = service.listCourse(map);
		
		int listNum =0;
		int n=0;
		for(Course dto :list) {
			listNum = dataCount - (start + n -1);
			dto.setListNum(listNum);
			n++;
		}
		
		String query = "";
		String listUrl = cp + "/admin/courseManage/list";
		
		
		
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

   
		return ".admin.courseManage.list";
	}
	
	// 강의 상세 정보 : AJAX-TEXT 응답
	@RequestMapping(value = "detail")
	public String detailCourse(@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			@RequestParam int num,
			Model model
			) throws Exception{
		
		int rows = 5;
		int total_page = 0;
		int dataCount = 0;

		Map<String, Object> map = new HashMap<>();
		map.put("num", num);

		total_page = myUtil.pageCount(rows, dataCount);
		if (current_page > total_page) {
			current_page = total_page;
		}

		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		
		Course dto = service.readCourse(num);
		Course courseState=service.readCourseState(num);
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
		
		model.addAttribute("dto",dto);
		model.addAttribute("courseState",courseState);
		model.addAttribute("listState",listState);
		model.addAttribute("listChapter", listChapter);
		
		return "admin/courseManage/detail";
	}
	
	@RequestMapping(value = "updateCourseState", method =RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateCourseState(Course dto) throws Exception{
		String state = "true";
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("num", dto.getNum());
			if(dto.getStateCode()==0) {
				map.put("enabled", 1);
			} else {
				map.put("enabled", 0);
			}
			
			service.updateCourseEnabled(map);
			
			service.insertCourseState(dto);
			
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("state", state);
		
		return model;
	}
	
	@RequestMapping("todayCourse")
	@ResponseBody
	public Map<String, Object> todayCourseCount() throws Exception{
		int todayCourseCount = 0;
		
		todayCourseCount = service.todayCount();
		Map<String, Object> map = new HashMap<String, Object>();
			
		map.put("todayCourseCount", todayCourseCount);
		
		return map;
	}
	
	@RequestMapping("totalCourse" )
	@ResponseBody
	public Map<String, Object> totalCourseCount() throws Exception{
		int totalCourseCount = 0;
		
		totalCourseCount = service.totalCount();
		Map<String, Object> map = new HashMap<String, Object>();
			
		map.put("totalCourseCount", totalCourseCount);
		
		return map;
	}
	
	@RequestMapping(value="courseAnalysis",produces="application/json; charset=utf-8")
	@ResponseBody
	public String listCourseSection() throws Exception{
		JSONArray jarr = new JSONArray();
		
		JSONObject job;
		List<Analysis> list = service.listCourseSection();
		
		for(int i=0; i<list.size(); i++) {
			job = new JSONObject();
			job.put("name", list.get(i).getSection().toString());
			job.put("value", list.get(i).getCount());
			jarr.put(job);
		}
		
		
		return jarr.toString();
	}
}
