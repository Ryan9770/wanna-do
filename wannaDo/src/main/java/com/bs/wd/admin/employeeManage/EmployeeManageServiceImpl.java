package com.bs.wd.admin.employeeManage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bs.wd.common.dao.CommonDAO;

@Service("admin.employeeManage.employeeManageService")
public class EmployeeManageServiceImpl implements EmployeeManageService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("employeeManage.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Employee> listEmployee(Map<String, Object> map) {
		List<Employee> list=null;
		try {
			list=dao.selectList("employeeManage.listEmployee", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Employee readEmployee(String userId) {
		Employee dto=null;
		
		try {
			dto=dao.selectOne("employeeManage.readEmployee", userId);
			
			if(dto!=null) {
				if(dto.getEmail()!=null) {
					String [] s=dto.getEmail().split("@");
					dto.setEmail1(s[0]);
					dto.setEmail2(s[1]);
				}

				if(dto.getTel()!=null) {
					String [] s=dto.getTel().split("-");
					dto.setTel1(s[0]);
					dto.setTel2(s[1]);
					dto.setTel3(s[2]);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	
	@Override
	public void updateEmployeeEnabled(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("employeeManage.updateEmployeeEnabled", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertEmployeeState(Employee dto) throws Exception {
		try {
			dao.updateData("employeeManage.insertEmployeeState", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Employee> listEmployeeState(String userId) {
		List<Employee> list=null;
		try {
			list=dao.selectList("employeeManage.listEmployeeState", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Employee readEmployeeState(String userId) {
		Employee dto=null;
		
		try {
			dto=dao.selectOne("employeeManage.readEmployeeState", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

}
