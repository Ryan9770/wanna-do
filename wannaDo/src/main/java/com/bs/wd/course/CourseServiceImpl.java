package com.bs.wd.course;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bs.wd.common.FileManager;
import com.bs.wd.common.dao.CommonDAO;



@Service("course.courseService")
public class CourseServiceImpl  implements CourseService {
	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertCourse(Course dto, String pathname) throws Exception {
		try {
			String saveFilename = fileManager.doFileUpload(dto.getSelectFile(), pathname);
			if (saveFilename != null) {
				dto.setImageFilename(saveFilename);
			
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
			result = dao.selectOne("course.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Course> listCourse(Map<String, Object> map) {
		List<Course> list = null;

		try {
			list = dao.selectList("course.listCourse", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public Course readCourse(int num) {
		Course dto = null;
		
		try {
			dto = dao.selectOne("course.readCourse", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateCourse(Course dto, String pathname) throws Exception {
		try {
			
			String saveFilename = fileManager.doFileUpload(dto.getSelectFile(), pathname);

			if (saveFilename != null) {
			
				if (dto.getImageFilename().length() != 0) {
					fileManager.doFileDelete(dto.getImageFilename(), pathname);
				}

				dto.setImageFilename(saveFilename);
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
	public void updateHitCount(int num) throws Exception {
		try {
			dao.updateData("course.updateHitCount", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertCourseLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("course.insertCourseLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public int courseLikeCount(int num) {
		int result = 0;
		
		try {
			result = dao.selectOne("course.courseLikeCount", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public void deleteCourseLike(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("course.deleteCourseLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


	@Override
	public boolean userCourseLiked(Map<String, Object> map) {
		boolean result = false;
		try {
			Course dto = dao.selectOne("course.userCourseLiked", map);
			if(dto != null) {
				result = true; 
			}
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
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



}
