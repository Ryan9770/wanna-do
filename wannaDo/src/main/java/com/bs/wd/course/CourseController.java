package com.bs.wd.course;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bs.wd.common.MyUtil;
import com.bs.wd.member.SessionInfo;









@Controller("course.courseController")
@RequestMapping("/course/*")
public class CourseController {
	@Autowired
	private CourseService service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value = "main")
	public String main(@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			Model model) throws Exception {
		Map<String, Object> map = new HashMap<>();
		
		
		List<Course> listCategory = service.listCategory(map);

		model.addAttribute("listCategory", listCategory);
		model.addAttribute("categoryNum", "0");
		model.addAttribute("pageNo", current_page);

		return ".course.main";
	}
	
	@RequestMapping(value = "list")
	public String list(@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			@RequestParam(defaultValue = "0") int categoryNum,
			HttpServletRequest req,
			Model model) throws Exception {

		String cp = req.getContextPath();
		
		int rows = 9999999;
		int total_page = 0;
		int dataCount = 0;

		if (req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("categoryNum", categoryNum);

		dataCount = service.dataCount(map);
		if (dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}

		if (total_page < current_page) {
			current_page = total_page;
		}

		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);

		List<Course> list = service.listCourse(map);
		int listNum, n = 0;
		for (Course dto : list) {
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
			n++;

		}
		
		String query = "";
		String listUrl = cp + "/course/list";
		String articleUrl = cp + "/course/article?page=" + current_page;
		if (keyword.length() != 0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}

		if (query.length() != 0) {
			listUrl = cp + "/course/list?" + query;
			articleUrl = cp + "/course/article?page=" + current_page + "&" + query;
		}

		String paging = myUtil.pagingMethod(current_page, total_page, listUrl);

		model.addAttribute("list", list);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);

		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		model.addAttribute("categoryNum", categoryNum);

		return "course/list";
	}
	
	@RequestMapping(value = "article")
	public String article(@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpSession session,
			Model model) throws Exception {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		keyword = URLDecoder.decode(keyword, "utf-8");

		String query = "page=" + page;
		if (keyword.length() != 0) {
			query += "&condition=" + condition + 
					"&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}

		service.updateHitCount(num);

		// 해당 레코드 가져 오기
		Course dto = service.readCourse(num);
		if (dto == null) {
			return "redirect:/course/main?" + query;
		}
		
		dto.setContent(myUtil.htmlSymbols(dto.getContent()));

		// 이전 글, 다음 글
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("num", num);



		// 게시글 좋아요 여부
		map.put("userId", info.getUserId());
		boolean userBoardLiked = service.userCourseLiked(map);

		model.addAttribute("dto", dto);


		model.addAttribute("userBoardLiked", userBoardLiked);
		
		model.addAttribute("page", page);
		model.addAttribute("query", query);

		return "course/article";
	}

	

	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String writeForm(Model model) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();


		List<Course> listCategory = service.listCategory(map);

		model.addAttribute("pageNo", "1");
		model.addAttribute("mode", "write");
		model.addAttribute("listCategory", listCategory);

		return ".course.write";
	}
	
	@RequestMapping(value = "write", method = RequestMethod.POST)
	public String writeSubmit(Course dto, HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String path = root + "uploads" + File.separator + "course";
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		try {
			dto.setUserId(info.getUserId());
			service.insertCourse(dto, path);
		} catch (Exception e) {

		}

		return "redirect:/course/main?pageNo=1";
	}
	
	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateForm(@RequestParam int num,
			@RequestParam int group,
			@RequestParam String page,
			HttpSession session,
			Model model) throws Exception {

		SessionInfo info = (SessionInfo) session.getAttribute("member");

		Course dto = service.readCourse(num);
		if (dto == null) {
			return "redirect:/course/list?group=" + group + "&page=" + page;
		}

		if (!info.getUserId().equals(dto.getUserId())) {
			return "redirect:/course/list?group=" + group + "&page=" + page;
		}

		Map<String, Object> map = new HashMap<String, Object>();

		List<Course> listCategory = service.listCategory(map);

		model.addAttribute("dto", dto);
		model.addAttribute("group", group);
		model.addAttribute("page", page);
		model.addAttribute("mode", "update");

		model.addAttribute("listCategory", listCategory);

		return ".course.write";
	}

	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String updateSubmit(Course dto,
			@RequestParam String pageNo,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "course";
		
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		try {
			dto.setUserId(info.getUserId());
			service.updateCourse(dto, pathname);
		} catch (Exception e) {

		}

		return "redirect:/course/list?group=" + pageNo;
	}

	@RequestMapping(value = "delete")
	public String delete(@RequestParam int num,
			@RequestParam int group,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		keyword = URLDecoder.decode(keyword, "utf-8");
		String query = "group=" + group + "&page=" + page;
		if (keyword.length() != 0) {
			query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}

		Map<String, Object> map = new HashMap<>();
		map.put("num", num);
		map.put("userId", info.getUserId());
		map.put("membership", info.getMembership());

		service.deleteCourse(map);

		return "redirect:/course/list?" + query;
	}
	
	@RequestMapping(value = "insertCourseLike", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertCourseLike(@RequestParam int num, 
			@RequestParam boolean userLiked,
			HttpSession session) {
		String state = "true";
		int courseLikeCount = 0;
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("num", num);
		paramMap.put("userId", info.getUserId());

		try {
			if(userLiked) {
				service.deleteCourseLike(paramMap);
			} else {
				service.insertCourseLike(paramMap);
			}
		} catch (DuplicateKeyException e) {
			state = "liked";
		} catch (Exception e) {
			state = "false";
		}

		courseLikeCount = service.courseLikeCount(num);

		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		model.put("courseLikeCount", courseLikeCount);

		return model;
	}
	
	@RequestMapping(value = "listAllCategory")
	public String listAllCategory(Model model) throws Exception {
		Map<String, Object> map = new HashMap<>();
		
		List<Course> listCategory = service.listCategory(map);
		model.addAttribute("listAllCategory", listCategory);
		return "course/listAllCategory";
	}

	// AJAX-JSON
	@RequestMapping(value = "listCategory")
	@ResponseBody
	public Map<String, Object> listCategory(@RequestParam String mode) throws Exception {
		Map<String, Object> map = new HashMap<>();
		
		List<Course> listCategory = service.listCategory(map);

		Map<String, Object> model = new HashMap<>();
		model.put("listCategory", listCategory);
		return model;
	}

	// AJAX-JSON
	@RequestMapping(value = "insertCategory", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertCategory(Course dto) throws Exception {

		String state = "false";
		try {
			service.insertCategory(dto);
			state = "true";
		} catch (Exception e) {
		}

		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}

	// AJAX-JSON
	@RequestMapping(value = "updateCategory", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateCategory(Course dto) throws Exception {

		String state = "false";
		try {
			service.updateCategory(dto);
			state = "true";
		} catch (Exception e) {
		}

		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}

	// AJAX-JSON
	@RequestMapping(value = "deleteCategory", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteCategory(@RequestParam int categoryNum) throws Exception {

		String state = "false";
		try {
			service.deleteCategory(categoryNum);
			state = "true";
		} catch (Exception e) {
		}

		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}

	
}
