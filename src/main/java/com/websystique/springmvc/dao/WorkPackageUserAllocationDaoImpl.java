package com.websystique.springmvc.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.websystique.springmvc.model.User;
import com.websystique.springmvc.model.WorkPackage;
import com.websystique.springmvc.model.WorkPackageUserAllocation;

@Repository("workPackageUserAllocationDao")
public class WorkPackageUserAllocationDaoImpl extends
		AbstractDao<Integer, WorkPackageUserAllocation> implements
		WorkPackageUserAllocationDao {

	static final Logger logger = LoggerFactory
			.getLogger(WorkPackageUserAllocationDaoImpl.class);

	public WorkPackageUserAllocation findById(int id) {
		WorkPackageUserAllocation workPackageUserAllocation = getByKey(id);

		if (workPackageUserAllocation != null) {
			Hibernate.initialize(workPackageUserAllocation.getWorkPackage());
			Hibernate.initialize(workPackageUserAllocation.getUser());
		}
		return workPackageUserAllocation;
	}

	@SuppressWarnings("unchecked")
	public List<WorkPackageUserAllocation> findAllWorkPackageUserAllocations() {
		Criteria criteria = createEntityCriteria().addOrder(Order.asc("id"));
		// criteria.add(Restrictions.eq("ssoId", sso));
		criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);// To
		// avoid
		// duplicates.
		List<WorkPackageUserAllocation> workPackages = (List<WorkPackageUserAllocation>) criteria
				.list();
		for (WorkPackageUserAllocation workPackageUserAllocation : workPackages) {
			Hibernate.initialize(workPackageUserAllocation.getWorkPackage());
			Hibernate.initialize(workPackageUserAllocation.getUser());

		}

		return workPackages;
	}

	@Override
	public List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsByWorkPackage(
			WorkPackage workPackage) {
		Criteria criteria = createEntityCriteria().addOrder(Order.asc("id"));
		criteria.add(Restrictions.eq("workPackage.id", workPackage.getId()));
		@SuppressWarnings("unchecked")
		List<WorkPackageUserAllocation> workPackageUserAllocations = (List<WorkPackageUserAllocation>) criteria
				.list();
		for (WorkPackageUserAllocation workPackageUserAllocation : workPackageUserAllocations) {
			Hibernate.initialize(workPackageUserAllocation.getWorkPackage());
			Hibernate.initialize(workPackageUserAllocation.getUser());
		}

		return workPackageUserAllocations;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsByUser(
			User user) {
		Criteria criteria = createEntityCriteria().addOrder(Order.asc("id"));
		criteria.add(Restrictions.eq("user.id", user.getId()));
		// criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);// To
		// avoid
		// duplicates.
		List<WorkPackageUserAllocation> workPackageUserAllocations = (List<WorkPackageUserAllocation>) criteria
				.list();
		for (WorkPackageUserAllocation workPackageUserAllocation : workPackageUserAllocations) {
			Hibernate.initialize(workPackageUserAllocation.getWorkPackage());
			Hibernate.initialize(workPackageUserAllocation.getUser());
		}
		return workPackageUserAllocations;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsByUserAndWorkPackage(
			WorkPackage workPackage, User user) {
		Criteria criteria = createEntityCriteria().addOrder(Order.asc("id"));
		criteria.add(Restrictions.eq("user.id", user.getId()));
		criteria.add(Restrictions.eq("workPackage.id", workPackage.getId()));
		// criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);// To
		// avoid
		// duplicates.

		List<WorkPackageUserAllocation> workPackageUserAllocations = (List<WorkPackageUserAllocation>) criteria
				.list();
		for (WorkPackageUserAllocation workPackageUserAllocation : workPackageUserAllocations) {
			Hibernate.initialize(workPackageUserAllocation.getWorkPackage());
			Hibernate.initialize(workPackageUserAllocation.getUser());
		}
		return workPackageUserAllocations;
	}

	public void save(WorkPackageUserAllocation workPackageUserAllocation) {
		persist(workPackageUserAllocation);
	}

	public void deleteById(int id) {	
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("id", id));
		WorkPackageUserAllocation workPackageUserAllocation = (WorkPackageUserAllocation) crit
				.uniqueResult();
		delete(workPackageUserAllocation);
	}

	public List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsBySum() {
		Query query = getSession()
				.createSQLQuery(
						"select id, work_package_id, user_id, sum(mJan) as mJan, sum(mFeb) as mFeb, sum(mMar) as mMar, sum(mApr) as mApr, sum(mMay) as mMay, sum(mJun) as mJun, sum(mJul) as mJul, sum(mAug) as mAug, sum(mSep) as mSep, sum(mOct) as mOct, sum(mNov) as mNov, sum(mDec) as mDec, Year_Name from work_package_app_user_allocations group by user_id;")
				.addEntity(WorkPackageUserAllocation.class);
		List<WorkPackageUserAllocation> workPackageUserAllocationsBySum = query.list();
		return workPackageUserAllocationsBySum;
	}

}
