package com.td.mace.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.td.mace.dao.ProjectDao;
import com.td.mace.model.Project;
import com.td.mace.model.User;
import com.td.mace.model.WorkPackage;
import com.td.mace.model.WorkPackageUserAllocation;

@Service("projectService")
@Transactional
public class ProjectServiceImpl implements ProjectService {

	@Autowired
	private ProjectDao projectDao;

	@Autowired
	private WorkPackageService workPackageService;
	
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
			entity.setEffectiveCost(project.getEffectiveCost());
			entity.setYearName(project.getYearName());
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
	
	
	
	public List<Project> findAllProjectsBySsoId(String ssoId) {
		return projectDao.findAllProjectsBySsoId(ssoId);
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

	@Override
	public List<Project> findAllProjectsByYearNameAndUser(User user, String yearName, String showAll) {
		List<Project> allProjects = findAllProjects();
		List<Project> projectsByYearNameAndUserList = new ArrayList<Project>();
		Set<Project> projectsByYearNameAndUserSet = new HashSet<Project>();
		/*for(Project project : allProjects ){
			if(project.getYearName().equals(yearName)){
				projectsByYearName.add(project);
			}
		}*/
		
		for(Project project : allProjects){

			//findAllUnfinishedWorkPackagesByUser
			/*if(showAll.equalsIgnoreCase("1")){
				for(WorkPackage workPackage : workPackageService.findAllUnfinishedWorkPackagesByUser(project.getId(),user.getSsoId())){
					for(WorkPackageUserAllocation workPackageUserAllocation : workPackage.getWorkPackageUserAllocations()){
						if(workPackageUserAllocation.getUser().getId() == user.getId() && workPackageUserAllocation.getYearName().equals(yearName)){
							projectsByYearNameAndUserSet.add(workPackageUserAllocation.getWorkPackage().getProject());
						}
						
					}
				}
			} else {*/
				for(WorkPackage workPackage : workPackageService.findAllWorkPackagesByUser(project.getId(),user.getSsoId())){
					for(WorkPackageUserAllocation workPackageUserAllocation : workPackage.getWorkPackageUserAllocations()){
						if(workPackageUserAllocation.getUser().getId() == user.getId() && workPackageUserAllocation.getYearName().equals(yearName)){
							projectsByYearNameAndUserSet.add(workPackageUserAllocation.getWorkPackage().getProject());
						}
						
					}
				}
			
			/*}*/
		}
		projectsByYearNameAndUserList.addAll(projectsByYearNameAndUserSet);
		
		return projectsByYearNameAndUserList;
	}

}
