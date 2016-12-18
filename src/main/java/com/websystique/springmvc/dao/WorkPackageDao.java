package com.websystique.springmvc.dao;

import java.util.List;

import com.websystique.springmvc.model.WorkPackage;


public interface WorkPackageDao {

	WorkPackage findById(int id);
	
	WorkPackage findByWorkPackageNumber(String workPackageNumber);
	
	WorkPackage findByWorkPackageName(String workPackageName);
	
	void save(WorkPackage WorkPackage);
	
	void deleteById(int id);
	
	List<WorkPackage> findAllWorkPackages();

}

