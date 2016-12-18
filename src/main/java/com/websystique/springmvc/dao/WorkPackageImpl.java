package com.websystique.springmvc.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.websystique.springmvc.model.WorkPackage;

@Repository("workPackageDao")
public class WorkPackageImpl extends AbstractDao<Integer, WorkPackage>
		implements WorkPackageDao {

	static final Logger logger = LoggerFactory.getLogger(WorkPackageImpl.class);

	public WorkPackage findById(int id) {
		WorkPackage workPackage = getByKey(id);

		if (workPackage != null) {
			Hibernate.initialize(workPackage.getUsers());
		}
		return workPackage;
	}

	public WorkPackage findByWorkPackageNumber(String workPackageNumber) {
		logger.info("WorkPackageNumber : {}", workPackageNumber);
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("workPackageNumber", workPackageNumber));
		WorkPackage workPackage = (WorkPackage) crit.uniqueResult();

		if (workPackage != null) {
			Hibernate.initialize(workPackage.getUsers());
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
			Hibernate.initialize(workPackage.getUsers());
		}
		return workPackage;
	}

	@SuppressWarnings("unchecked")
	public List<WorkPackage> findAllWorkPackages() {
		Criteria criteria = createEntityCriteria().addOrder(
				Order.asc("workPackageName"));
		// criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);// To
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

	public void save(WorkPackage workPackage) {
		persist(workPackage);
	}

	public void deleteById(int id) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("id", id));
		WorkPackage workPackage = (WorkPackage) crit.uniqueResult();
		delete(workPackage);
	}

}
