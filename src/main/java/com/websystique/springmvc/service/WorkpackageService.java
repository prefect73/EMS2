package com.websystique.springmvc.service;

import java.util.List;

import com.websystique.springmvc.model.Workpackage;


public interface WorkpackageService {
	
	Workpackage findById(int id);
	
	Workpackage findByWorkpackageNumber(String workpackageNumber);
	
	Workpackage findByWorkpackageName(String workpackageName);
	
	void saveWorkpackage(Workpackage workpackage);
	
	void updateWorkpackage(Workpackage workpackage);
	
	void deleteWorkpackageById(int id);

	List<Workpackage> findAllWorkpackages(); 
	

}