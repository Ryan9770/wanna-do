package com.bs.wd.schedule;

import java.util.List;
import java.util.Map;

public interface ScheduleService {
	public void insertSchedule(Schedule dto) throws Exception;
	public List<Schedule> listMonth(Map<String, Object> map) throws Exception;
	
	public Schedule readSchedule(int num) throws Exception;
	
	public void updateSchedule(Schedule dto) throws Exception;
	public void deleteSchedule(Map<String, Object> map) throws Exception;
	
	public void insertCategory(Map<String, Object> map) throws Exception;
	public List<Schedule> listCategory(Map<String, Object> map) throws Exception;
	public void deleteCategory(Map<String, Object> map) throws Exception;
	
}
