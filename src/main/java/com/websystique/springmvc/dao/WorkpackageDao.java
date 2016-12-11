package com.websystique.springmvc.dao;

import java.util.List;

import com.websystique.springmvc.model.Workpackage;


public interface WorkpackageDao {

	Workpackage findById(int id);
	
	Workpackage findByWorkpackageNumber(String workpackageNumber);
	
	Workpackage findByWorkpackageName(String workpackageName);
	
	void save(Workpackage Workpackage);
	
	void deleteById(String id);
	
	List<Workpackage> findAllWorkpackages();

}

