package com.td.mace.dao;

import java.util.List;

import com.td.mace.model.Project;


public interface ProjectDao {

	Project findById(int id);
	
	Project findByProjectNumber(String projectNumber);
	
	Project findByProjectName(String projectNumber);
	
	void save(Project Project);
	
	void deleteByProjectNumber(String projectNumber);
	
	List<Project> findAllProjects();
	
	List<Project> findAllProjectsBySsoId(String ssoId);

    Integer getProjectIdByByWorkPackageId(Integer workPackageId);
}

