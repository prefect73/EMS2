package com.td.mace.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
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
		List<Project> allProjects = new ArrayList<Project>();
		Set<Project> allProjectsSet = new HashSet<Project>();
		List<Project> allProjectsBySsoId = findAllProjectsBySsoId(user.getSsoId());
		for (Project project : allProjectsBySsoId) {
			List<WorkPackage> workPackages = project.getWorkPackages();
			List<WorkPackage> tempWorkPackages = new ArrayList<WorkPackage>();
			for (WorkPackage workPackage : workPackages) {
				List<WorkPackageUserAllocation> workPackageUserAllocations = workPackage.getWorkPackageUserAllocations();
				List<WorkPackageUserAllocation> tempWorkPackageUserAllocations = new ArrayList<WorkPackageUserAllocation>();
				for (WorkPackageUserAllocation workPackageUserAllocation : workPackageUserAllocations) {
					if(workPackageUserAllocation.getUser().getId() == user.getId() && workPackageUserAllocation.getYearName().equals(yearName)){
						Project pr = workPackageUserAllocation.getWorkPackage().getProject();
						WorkPackage wp = workPackageUserAllocation.getWorkPackage();
						tempWorkPackageUserAllocations.add(workPackageUserAllocation);
						wp.setWorkPackageUserAllocations(tempWorkPackageUserAllocations);
						tempWorkPackages.add(wp);
						if(showAll.equals("0") && wp.getStatus().equals("Abgeschlossen") || showAll.equals("0") && wp.getStatus().equals("Finished") ){
							tempWorkPackages.remove(wp);
						}
						pr.setWorkPackages(tempWorkPackages);
						allProjectsSet.add(pr);
					}
				}
			}
		}
		allProjects.addAll(allProjectsSet);
		
		for (Iterator iterator = allProjects.iterator();  iterator.hasNext();) {
			Project project = (Project) iterator.next();
			if(project.getWorkPackages().size() == 0){
				iterator.remove();
			}
		}
		
		return allProjects;
	}

	@Override
	public Integer getProjectIdByByWorkPackageId(Integer workPackageId) {
		return projectDao.getProjectIdByByWorkPackageId(workPackageId);
	}
}
