package com.td.mace.service;

import java.util.List;

import com.td.mace.model.Project;
import com.td.mace.model.User;

public interface ProjectService {

	Project findById(int id);

	Project findByProjectNumber(String projectNumber);

	Project findByProjectName(String projectName);

	void saveProject(Project project);

	void updateProject(Project project);

	void deleteProjectByProjectNumber(String projectNumber);

	List<Project> findAllProjects();

	List<Project> findAllProjectsBySsoId(String ssoId);

	boolean isProjectNumberUnique(Integer id, String projectNumber);

	boolean isProjectNameUnique(Integer id, String projectName);

	List<Project> findAllProjectsByYearNameAndUser(User user, String yearName, String showAll);

}