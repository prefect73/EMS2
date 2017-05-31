package com.td.mace.service;

import java.util.List;

import com.td.mace.model.User;
import com.td.mace.model.WorkPackage;


public interface WorkPackageService {
	
	WorkPackage findById(int id);
	WorkPackage findById(int id, String ssoId);
	
	WorkPackage findByWorkPackageNumber(String workPackageNumber);
	
	WorkPackage findByWorkPackageName(String workPackageName);
	
	void saveWorkPackage(WorkPackage workPackage);
	
	void updateWorkPackage(WorkPackage workPackage);
	
	void updateWorkPackage(WorkPackage workPackage, User user);
	
	void updateWorkPackageForTimeRecording(WorkPackage workPackage, User user);
	
	void deleteWorkPackageById(int id);

	List<WorkPackage> findAllWorkPackages(); 
	
	List<WorkPackage> findByProjectID(int projectID);

	List<WorkPackage> findAllWorkPackagesBySSOId(String ssoId);
	
	List<WorkPackage> findAllWorkPackagesByProjectIdAndSsoId(int projectId, String ssoId);
	
	List<WorkPackage> findAllWorkPackagesByUser(int projectId,String ssoId);
	
	void updateCalculatedCost(WorkPackage workPackage);
	

}