package com.td.mace.dao;

import com.td.mace.model.UserAttendance;

import java.util.List;


public interface UserAttendanceDao {

	UserAttendance findById(int id);
	
	UserAttendance findByUserId(String userId);
	
	UserAttendance findBySSOId(String userAttendanceName);
	
	void save(UserAttendance UserAttendance);
	
	void deleteById(int id);
	
	void deleteByUserId(int id);
	
	List<UserAttendance> findAllUserAttendances();
	
	List<UserAttendance> findAllUserAttendancesBySSOId(String ssoId); 
	
	List<UserAttendance> findAllUserAttendancesUpdated();

}

