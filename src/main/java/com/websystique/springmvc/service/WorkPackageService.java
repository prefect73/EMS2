package com.websystique.springmvc.service;

import java.util.List;

import com.websystique.springmvc.model.WorkPackage;


public interface WorkPackageService {
	
	WorkPackage findById(int id);
	
	WorkPackage findByWorkPackageNumber(String workPackageNumber);
	
	WorkPackage findByWorkPackageName(String workPackageName);
	
	void saveWorkPackage(WorkPackage workPackage);
	
	void updateWorkPackage(WorkPackage workPackage);
	
	void deleteWorkPackageById(int id);

	List<WorkPackage> findAllWorkPackages(); 
	
	List<WorkPackage> findByProjectID(int projectID);
	

}