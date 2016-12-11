package com.websystique.springmvc.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.websystique.springmvc.model.Workpackage;

@Repository("workpackageDao")
public class WorkpackageImpl extends AbstractDao<Integer, Workpackage>
		implements WorkpackageDao {

	static final Logger logger = LoggerFactory.getLogger(WorkpackageImpl.class);

	public Workpackage findById(int id) {
		Workpackage workpackage = getByKey(id);
		return workpackage;
	}

	public Workpackage findByWorkpackageNumber(String workpackageNumber) {
		logger.info("WorkpackageNumber : {}", workpackageNumber);
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("workpackageNumber", workpackageNumber));
		Workpackage workpackage = (Workpackage) crit.uniqueResult();
		return workpackage;
	}
	
	@Override
	public Workpackage findByWorkpackageName(String workpackageName) {
		logger.info("workpackageName : {}", workpackageName);
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("workpackageName", workpackageName));
		Workpackage workpackage = (Workpackage) crit.uniqueResult();
		return workpackage;
	}

	@SuppressWarnings("unchecked")
	public List<Workpackage> findAllWorkpackages() {
		Criteria criteria = createEntityCriteria().addOrder(
				Order.asc("firstName"));
		criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);// To avoid
																		// duplicates.
		List<Workpackage> workpackages = (List<Workpackage>) criteria.list();

		// No need to fetch workpackageProfiles since we are not showing them on
		// list page. Let them lazy load.
		// Uncomment below lines for eagerly fetching of workpackageProfiles if
		// you want.
		/*
		 * for(Workpackage workpackage : workpackages){
		 * Hibernate.initialize(workpackage.getWorkpackageProfiles()); }
		 */
		return workpackages;
	}

	public void save(Workpackage workpackage) {
		persist(workpackage);
	}

	public void deleteById(String id) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("id", id));
		Workpackage workpackage = (Workpackage) crit.uniqueResult();
		delete(workpackage);
	}

	

}
