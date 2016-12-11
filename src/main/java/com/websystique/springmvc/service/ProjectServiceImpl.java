package com.websystique.springmvc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.websystique.springmvc.dao.ProjectDao;
import com.websystique.springmvc.model.Project;

@Service("projectService")
@Transactional
public class ProjectServiceImpl implements ProjectService {

	@Autowired
	private ProjectDao dao;

	public Project findById(int id) {
		return dao.findById(id);
	}

	public Project findByProjectNumber(String projectNumber) {
		Project project = dao.findByProjectNumber(projectNumber);
		return project;
	}

	@Override
	public Project findByProjectName(String projectName) {
		Project project = dao.findByProjectName(projectName);
		return project;
	}

	public void saveProject(Project project) {
		dao.save(project);
	}

	/*
	 * Since the method is running with Transaction, No need to call hibernate
	 * update explicitly. Just fetch the entity from db and update it with
	 * proper values within transaction. It will be updated in db once
	 * transaction ends.
	 */
	public void updateProject(Project project) {
		Project entity = dao.findById(project.getId());
		if (entity != null) {
			entity.setProjectNumber(project.getProjectNumber());
			entity.setProjectName(project.getProjectName());
			entity.setCustomerName(project.getCustomerName());
			entity.setOfferedCost(project.getOfferedCost());
			entity.setTotalCost(project.getTotalCost());
			/*entity.setUsers((project.getUsers()));
			entity.setWorkPackages(project.getWorkPackages());*/
		}
	}

	public void deleteProjectByProjectNumber(String projectNumber) {
		dao.deleteByProjectNumber(projectNumber);
	}

	public List<Project> findAllProjects() {
		return dao.findAllProjects();
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
