package com.td.mace.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.td.mace.model.Project;
import com.td.mace.model.User;

@Repository("projectDao")
public class ProjectImpl extends AbstractDao<Integer, Project> implements
		ProjectDao {

	static final Logger logger = LoggerFactory.getLogger(ProjectImpl.class);
	
	@Autowired
	private UserDao userDao;

	public Project findById(int id) {
		Project project = getByKey(id);

		if (project != null) {
			Hibernate.initialize(project.getUsers());
			Hibernate.initialize(project.getWorkPackages());
		}

		return project;
	}

	public Project findByProjectNumber(String projectNumber) {
		logger.info("ProjectNumber : {}", projectNumber);
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("projectNumber", projectNumber));
		Project project = (Project) crit.uniqueResult();

		if (project != null) {
			Hibernate.initialize(project.getUsers());
			Hibernate.initialize(project.getWorkPackages());
		}

		return project;
	}

	public Project findByProjectName(String projectName) {
		logger.info("ProjectName : {}", projectName);
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("projectName", projectName));
		Project project = (Project) crit.uniqueResult();

		if (project != null) {
			Hibernate.initialize(project.getUsers());
			Hibernate.initialize(project.getWorkPackages());
		}

		return project;
	}

	@SuppressWarnings("unchecked")
	public List<Project> findAllProjects() {
		Criteria criteria = createEntityCriteria().addOrder(
				Order.asc("id"));
		criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);// To avoid
																		// duplicates.
		List<Project> projects = (List<Project>) criteria.list();

		// No need to fetch projectProfiles since we are not showing them on
		// list page. Let them lazy load.
		// Uncomment below lines for eagerly fetching of projectProfiles if you
		// want.
		
		  for(Project project : projects){
			  Hibernate.initialize(project.getUsers());
				Hibernate.initialize(project.getWorkPackages()); 
		  }
		 
		return projects;
	}
	
	@SuppressWarnings("unchecked")
	public List<Project> findAllProjectsBySsoId(String ssoId) {
		User user = userDao.findBySSO(ssoId);
		Query query = getCurrentSession().createSQLQuery(
				"select distinct p.* from project p join work_package w on p.id = w.project_id join work_package_app_user_allocations wa on w.id = wa.work_package_id where wa.user_id = :userId")
				.addEntity(Project.class);
		query.setParameter("userId", user.getId());
		List<Project> projects = query.list();
		return projects;
	}	

	public void save(Project project) {
		persist(project);
	}

	public void deleteByProjectNumber(String projectNumber) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("projectNumber", projectNumber));
		Project project = (Project) crit.uniqueResult();
		delete(project);
	}

}
