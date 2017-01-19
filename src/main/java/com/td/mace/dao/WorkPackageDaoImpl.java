package com.td.mace.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.td.mace.model.User;
import com.td.mace.model.UserAttendance;
import com.td.mace.model.WorkPackage;
import com.td.mace.model.WorkPackageUserAllocation;

@Repository("workPackageDao")
public class WorkPackageDaoImpl extends AbstractDao<Integer, WorkPackage>
		implements WorkPackageDao {

	static final Logger logger = LoggerFactory.getLogger(WorkPackageDaoImpl.class);

	public WorkPackage findById(int id) {
		WorkPackage workPackage = getByKey(id);

		if (workPackage != null) {
			Hibernate.initialize(workPackage.getWorkPackageUserAllocations());
		}
		return workPackage;
	}

	public WorkPackage findByWorkPackageNumber(String workPackageNumber) {
		logger.info("WorkPackageNumber : {}", workPackageNumber);
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("workPackageNumber", workPackageNumber));
		WorkPackage workPackage = (WorkPackage) crit.uniqueResult();

		if (workPackage != null) {
			Hibernate.initialize(workPackage.getWorkPackageUserAllocations());
		}
		return workPackage;
	}

	@Override
	public WorkPackage findByWorkPackageName(String workPackageName) {
		logger.info("workPackageName : {}", workPackageName);
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("workPackageName", workPackageName));
		WorkPackage workPackage = (WorkPackage) crit.uniqueResult();

		if (workPackage != null) {
			Hibernate.initialize(workPackage.getWorkPackageUserAllocations());
		}
		return workPackage;
	}

	@SuppressWarnings("unchecked")
	public List<WorkPackage> findAllWorkPackages() {
		Criteria criteria = createEntityCriteria().addOrder(
				Order.asc("workPackageName"));
		criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);// To
		// avoid
		// duplicates.
		List<WorkPackage> workPackages = (List<WorkPackage>) criteria.list();

		// No need to fetch workPackageProfiles since we are not showing them on
		// list page. Let them lazy load.
		// Uncomment below lines for eagerly fetching of workPackageProfiles if
		// you want.

		for (WorkPackage workPackage : workPackages) {
			Hibernate.initialize(workPackage.getProject());
		}

		return workPackages;
	}
	
	@SuppressWarnings("unchecked")
	public List<WorkPackage> findAllWorkPackagesBySSOId(String ssoId) {
		Criteria criteria = createEntityCriteria();
		criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
		// criteria.add(Restrictions.eq("ssoId", ssoId));
		criteria.addOrder(Order.asc("id"));
		List<WorkPackage> workPackages = (List<WorkPackage>) criteria
				.list();
		List<WorkPackage> allowedUserAttendances = new ArrayList<WorkPackage>();

		for (WorkPackage workPackage : workPackages) {
			Hibernate.initialize(workPackage.getWorkPackageUserAllocations());
			for(WorkPackageUserAllocation workPackageUserAllocation  : workPackage.getWorkPackageUserAllocations()){
				User user = workPackageUserAllocation.getUser();
				if (user.getSsoId().equalsIgnoreCase(ssoId)) {
					allowedUserAttendances.add(workPackage);
					break;
				}
			}
			
		}
		return allowedUserAttendances;
	}

	public void save(WorkPackage workPackage) {
		persist(workPackage);
	}

	public void deleteById(int id) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("id", id));
		WorkPackage workPackage = (WorkPackage) crit.uniqueResult();
		delete(workPackage);
	}
	
	@SuppressWarnings("unchecked")
	 public List<WorkPackage> findByProjectID(int projectID) {
	  Query query = getSession().createSQLQuery("select * from work_package where project_id = :projectId").addEntity(WorkPackage.class);
	  query.setParameter("projectId", projectID);
	  List<WorkPackage> workPackages = query.list();
	  return workPackages;
	 }

	@Override
	public Session getHibernateSession() {
		return super.getSession();
		
	}
	
	

}
