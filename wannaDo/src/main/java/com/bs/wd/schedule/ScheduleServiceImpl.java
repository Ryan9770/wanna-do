package com.bs.wd.schedule;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bs.wd.common.dao.CommonDAO;

@Service("schedule.scheduleService")
public class ScheduleServiceImpl implements ScheduleService {

	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertSchedule(Schedule dto) throws Exception {
		try {
			if(dto.getAll_day() != null) {
				dto.setStime("");
				dto.setEtime("");
			}
			
			if(dto.getStime().length() == 0 && dto.getEtime().length() == 0 && dto.getSday().equals(dto.getEday()))
					dto.setEday("");
			if(dto.getRepeat_cycle() != 0 ) {
				dto.setEday("");
				dto.setStime("");
				dto.setEtime("");
			}
			
			dao.insertData("schedule.insertSchedule", dto);
		} catch (Exception e) {
			throw e;
		}
		
	}

	@Override
	public List<Schedule> listMonth(Map<String, Object> map) throws Exception {
		List<Schedule> list = null;
		
		try {
			list = dao.selectList("schedule.listMonth", map);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	@Override
	public Schedule readSchedule(int num) throws Exception {
		Schedule dto = null;
		try {
			dto = dao.selectOne("schedule.readSchedule", num);
		} catch (Exception e) {
			throw e;
		}
		return dto;
	}

	@Override
	public void updateSchedule(Schedule dto) throws Exception {
		try {
			if(dto.getAll_day() != null) {
				dto.setStime("");
				dto.setEtime("");
			}
			
			if(dto.getStime().length() == 0 && dto.getEtime().length() == 0 && dto.getSday().equals(dto.getEday()))
					dto.setEday("");
			if(dto.getRepeat_cycle() != 0 ) {
				dto.setEday("");
				dto.setStime("");
				dto.setEtime("");
			}
			
			dao.insertData("schedule.updateSchedule", dto);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public void deleteSchedule(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("schedule.deleteSchedule", map);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public void insertCategory(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("schedule.insertCategory", map);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public List<Schedule> listCategory(Map<String, Object> map) throws Exception {
		List<Schedule> list = null;
		try {
			list = dao.selectList("schedule.listCategory", map);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	@Override
	public void deleteCategory(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("schedule.deleteCategory", map);
		} catch (Exception e) {
			throw e;
		}
		
	}

	@Override
	public void insertScheduleLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("schedule.insertScheduleLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteScheduleLike(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("schedule.deleteScheduleLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int scheduleLikeCount(int num) {
		int result = 0;
		
		try {
			result = dao.selectOne("schedule.scheduleLikeCount", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public boolean userScheduleLiked(Map<String, Object> map) {
		boolean result = false;
		try {
			Schedule dto = dao.selectOne("schedule.userScheduleLiked", map);
			if(dto != null) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
