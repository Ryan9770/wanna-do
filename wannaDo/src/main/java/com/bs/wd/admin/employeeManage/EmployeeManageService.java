package com.bs.wd.admin.employeeManage;

import java.util.List;
import java.util.Map;

public interface EmployeeManageService {
	public int dataCount(Map<String, Object> map);
	public List<Employee> listEmployee(Map<String, Object> map);
	
	public Employee readEmployee(String userId);
	
	public void updateEmployeeEnabled(Map<String, Object> map) throws Exception;
	public void insertEmployeeState(Employee dto) throws Exception;
	public List<Employee> listEmployeeState(String userId);
	public Employee readEmployeeState(String userId);
}
