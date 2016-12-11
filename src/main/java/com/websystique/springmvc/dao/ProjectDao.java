package com.websystique.springmvc.dao;

import java.util.List;

import com.websystique.springmvc.model.Project;


public interface ProjectDao {

	Project findById(int id);
	
	Project findByProjectNumber(String projectNumber);
	
	Project findByProjectName(String projectNumber);
	
	void save(Project Project);
	
	void deleteByProjectNumber(String projectNumber);
	
	List<Project> findAllProjects();

}

