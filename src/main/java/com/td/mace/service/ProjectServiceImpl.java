package com.td.mace.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.td.mace.dao.ProjectDao;
import com.td.mace.model.Project;

@Service("projectService")
@Transactional
public class ProjectServiceImpl implements ProjectService {

	@Autowired
	private ProjectDao projectDao;

	public Project findById(int id) {
		return projectDao.findById(id);
	}

	public Project findByProjectNumber(String projectNumber) {
		Project project = projectDao.findByProjectNumber(projectNumber);
		return project;
	}

	@Override
	public Project findByProjectName(String projectName) {
		Project project = projectDao.findByProjectName(projectName);
		return project;
	}

	public void saveProject(Project project) {
		projectDao.save(project);
	}

	/*
	 * Since the method is running with Transaction, No need to call hibernate
	 * update explicitly. Just fetch the entity from db and update it with
	 * proper values within transaction. It will be updated in db once
	 * transaction ends.
	 */
	public void updateProject(Project project) {
		Project entity = projectDao.findById(project.getId());
		if (entity != null) {
			entity.setProjectNumber(Integer.toString(project.getId()));
			entity.setProjectName(project.getProjectName());
			entity.setCustomerName(project.getCustomerName());
			entity.setOfferedCost(project.getOfferedCost());
			entity.setTotalCost(project.getTotalCost());
			entity.setUsers((project.getUsers()));
			/*entity.setWorkPackages(project.getWorkPackages());*/
		}
	}

	public void deleteProjectByProjectNumber(String projectNumber) {
		projectDao.deleteByProjectNumber(projectNumber);
	}

	public List<Project> findAllProjects() {
		return projectDao.findAllProjects();
	}

	@Override
	public boolean isProjectNumberUnique(Integer id, String projectNumber) {
		Project project = findByProjectNumber(projectNumber);
		return (project == null || ((id != null) && (project.getId() == id)));
	}

	@Override
	public boolean isProjectNameUnique(Integer id, String projectName) {
		Project project = findByProjectName(projectName);
		return (project == null || ((id != null) && (project.getId() == id)));
	}

}
