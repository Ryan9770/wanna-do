package com.bs.wd.creator.courseManage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bs.wd.common.FileManager;
import com.bs.wd.common.dao.CommonDAO;

@Service("creator.courseManage.courseManageService")
public class CourseManageServiceImpl implements CourseManageService{

	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertCourse(Course dto, String pathname) throws Exception {
		try {
			String saveFilename = fileManager.doFileUpload(dto.getSelectFile(), pathname);
			if(saveFilename!=null) {
				dto.setImageFile(saveFilename);
				
				dao.insertData("course.insertCourse", dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("creatorCourseManage.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Course> listCourse(Map<String, Object> map) {
		List<Course> list = null;
		try {
			list = dao.selectList("creatorCourseManage.listCourse", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Course readCourse(int num) {
		Course dto = null;
		
		try {
			dto = dao.selectOne("creatorCourseManage.readCourse", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateCourseEnabled(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Course> listCategory(Map<String, Object> map) {
		List<Course> listCategory = null;
		
		try {
			listCategory = dao.selectList("course.listCategory", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listCategory;
	}

	@Override
	public void updateCourse(Course dto, String pathname) throws Exception {
		try {
			String saveFilename = fileManager.doFileUpload(dto.getSelectFile(), pathname);
			
			if(saveFilename != null) {
				if(dto.getImageFile().length()!=0) {
					fileManager.doFileDelete(dto.getImageFile(), pathname);
				}
				dto.setImageFile(saveFilename);
			}
			dao.updateData("course.updateCourse", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteCourse(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("course.deleteCourse", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertCategory(Course dto) throws Exception {
		try {
			dao.insertData("course.insertCategory", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateCategory(Course dto) throws Exception {
		try {
			dao.updateData("course.updateCategory", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteCategory(int categoryNum) throws Exception {
		try {
			dao.deleteData("course.deleteCategory", categoryNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Course> listCourseState(int num) {
		List<Course> list = null;
		
		try {
			list = dao.selectList("creatorCourseManage.listCourseState",num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Course> listChapter(int num) {
		List<Course> list = null;
		
		try {
			list = dao.selectList("creatorCourseManage.listChapter",num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Course readCourseState(int num) {
		Course dto = null;
		try {
			dto = dao.selectOne("creatorCourseManage.readCourseState", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

}
