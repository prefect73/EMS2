package com.td.mace.dao;

import com.td.mace.model.Project;

import java.util.List;


public interface ProjectDao {

	Project findById(int id);
	
	Project findByProjectNumber(String projectNumber);
	
	Project findByProjectName(String projectNumber);
	
	void save(Project Project);
	
	void deleteByProjectNumber(String projectNumber);
	
	List<Project> findAllProjects();
	
	List<Project> findAllProjectsBySsoId(String ssoId);

    Integer getProjectIdByByWorkPackageId(Integer workPackageId);

    List<String> findAllProjectsCustomers();
}

