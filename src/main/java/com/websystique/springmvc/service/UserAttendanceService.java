package com.websystique.springmvc.service;

import java.util.List;

import com.websystique.springmvc.model.UserAttendance;


public interface UserAttendanceService {
	
	UserAttendance findById(int id);
	
	UserAttendance findByUserId(String userId);
	
	UserAttendance findBySSOId(String ssoId);
	
	void saveUserAttendance(UserAttendance workpackage);
	
	void updateUserAttendance(UserAttendance workpackage);
	
	void deleteUserAttendanceById(int id);
	
	void deleteUserAttendanceByUserId(int userId);

	List<UserAttendance> findAllUserAttendances(); 
	

}