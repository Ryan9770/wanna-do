package com.bs.wd.admin.scheduleManage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bs.wd.common.dao.CommonDAO;

@Service("admin.scheduleManage.scheduleManageService")
public class ScheduleManageServiceImpl implements ScheduleManageService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertSchedule(Schedule dto) throws Exception {
		try {
			if(dto.getAll_day()!=null) {
				dto.setStime("");
				dto.setEtime("");
			}
			
			if(dto.getStime().length()==0&&dto.getEtime().length()==0&&dto.getSday().equals(dto.getEday()))
				dto.setEday("");
			
			if(dto.getRepeat_cycle()!=0) {
				dto.setEday("");
				dto.setStime("");
				dto.setEtime("");
			}
			
			dao.insertData("scheduleManage.insertSchedule", dto);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public List<Schedule> listMonth(Map<String, Object> map) throws Exception{
		List<Schedule> list=null;
		try {
			list=dao.selectList("scheduleManage.listMonth", map);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	@Override
	public Schedule readSchedule(int num) throws Exception{
		Schedule dto=null;
		try {
			dto=dao.selectOne("scheduleManage.readSchedule", num);
		} catch (Exception e) {
			throw e;
		}
		return dto;
	}

	@Override
	public void updateSchedule(Schedule dto) throws Exception{
		try {
			if(dto.getAll_day()!=null) {
				dto.setStime("");
				dto.setEtime("");
			}
			
			if(dto.getStime().length()==0&&dto.getEtime().length()==0&&dto.getSday().equals(dto.getEday()))
				dto.setEday("");
			
			if(dto.getRepeat_cycle()!=0) {
				dto.setEday("");
				dto.setStime("");
				dto.setEtime("");
			}
			dao.updateData("scheduleManage.updateSchedule", dto);
		} catch (Exception e) {
			throw e;
		}

	}

	@Override
	public void deleteSchedule(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("scheduleManage.deleteSchedule", map);
		} catch (Exception e) {
			throw e;
		}
	}
	
	@Override
	public void insertCategory(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("scheduleManage.insertCategory", map);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public List<Schedule> listCategory(Map<String, Object> map) throws Exception {
		List<Schedule> list = null;
		try {
			list = dao.selectList("scheduleManage.listCategory", map);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	@Override
	public void deleteCategory(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("scheduleManage.deleteCategory", map);
		} catch (Exception e) {
			throw e;
		}
	}
}
