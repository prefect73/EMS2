package com.td.mace.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.td.mace.model.User;
import com.td.mace.model.WorkPackage;
import com.td.mace.model.WorkPackageUserAllocation;

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
	public List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsByUserAndYearName(
			User user, String yearName) {
		Criteria criteria = createEntityCriteria().addOrder(Order.asc("id"));
		criteria.add(Restrictions.eq("user.id", user.getId()));
		criteria.add(Restrictions.eq("yearName", yearName));
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
						"select id, work_package_id, user_id, sum(total_planned_days) as total_planned_days, sum(mjan) as mjan, sum(mfeb) as mfeb, sum(mmar) as mmar, sum(mapr) as mapr, sum(mmay) as mmay, sum(mjun) as mjun, sum(mjul) as mjul, sum(maug) as maug, sum(msep) as msep, sum(moct) as moct, sum(mnov) as mnov, sum(mdec) as mdec, sum(emjan) as emjan, sum(emfeb) as emfeb, sum(emmar) as emmar, sum(emapr) as emapr, sum(emmay) as emmay, sum(emjun) as emjun, sum(emjul) as emjul, sum(emaug) as emaug, sum(emsep) as emsep, sum(emoct) as emoct, sum(emnov) as emnov, sum(emdec) as emdec,eemjan,eemfeb,eemmar,eemapr,eemmay,eemjun,eemjul,eemaug,eemsep,eemoct,eemnov,eemdec, year_name from work_package_app_user_allocations group by user_id,year_name")
				.addEntity(WorkPackageUserAllocation.class);
		List<WorkPackageUserAllocation> workPackageUserAllocationsBySum = query
				.list();
		return workPackageUserAllocationsBySum;
	}

	public List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsBySumOfAllMonths() {
		Query query = getSession()
				.createSQLQuery(
						"select id, work_package_id, user_id,total_planned_days, mjan, mfeb, mmar, mapr, mmay, mjun, mjul, maug, msep, moct, mnov, mdec, sum(mjan)+sum(mfeb)+sum(mmar)+sum(mapr)+sum(mmay)+sum(mjun)+sum(mjul)+sum(maug)+sum(msep)+sum(moct)+sum(mnov)+sum(mdec) as totalyearhours, year_name from work_package_app_user_allocations group by work_package_id")
				.addEntity(WorkPackageUserAllocation.class);
		List<WorkPackageUserAllocation> workPackageUserAllicationsBySumOfAllMonths = query
				.list();
		return workPackageUserAllicationsBySumOfAllMonths;
	}

	public List<WorkPackageUserAllocation> getWorkPackageHoursForAllUsers(
			String workPackageNumber) {
		// Query internalQuery =
		// getSession().createSQLQuery("select id, work_package_id, user_id, sum(mJan) as mJan, sum(mFeb) as mFeb, sum(mMar) as mMar, sum(mApr) as mApr, sum(mMay) as mMay, sum(mJun) as mJun, sum(mJul) as mJul, sum(mAug) as mAug, sum(mSep) as mSep, sum(mOct) as mOct, sum(mNov) as mNov, sum(mDec) as mDec, Year_Name from work_package_app_user_allocations where work_package_id=:workPackageID group by user_id;").addEntity(WorkPackageUserAllocation.class);
		Query query = getSession()
				.createSQLQuery(
						"select id, work_package_id, user_id,sum(total_planned_days) as total_planned_days, sum(mjan) as mjan, sum(mfeb) as mfeb, sum(mmar) as mmar, sum(mapr) as mapr, sum(mmay) as mmay, sum(mjun) as mjun, sum(mjul) as mjul, sum(maug) as maug, sum(msep) as msep, sum(moct) as moct, sum(mnov) as mnov, sum(mdec) as mdec,sum(emjan) as emjan, sum(emfeb) as emfeb, sum(emmar) as emmar, sum(emapr) as emapr, sum(emmay) as emmay, sum(emjun) as emjun, sum(emjul) as emjul, sum(emaug) as emaug, sum(emsep) as emsep, sum(emoct) as emoct, sum(emnov) as emnov, sum(emdec) as emdec,eemjan,eemfeb,eemmar,eemapr,eemmay,eemjun,eemjul,eemaug,eemsep,eemoct,eemnov,eemdec, year_name from work_package_app_user_allocations where work_package_id=(select id from work_package where work_package_number= :workPackageNumber) group by user_id")
				.addEntity(WorkPackageUserAllocation.class);
		query.setParameter("workPackageNumber", workPackageNumber);
		@SuppressWarnings("unchecked")
		List<WorkPackageUserAllocation> workPackageHoursByUserID = query.list();

		return workPackageHoursByUserID;
	}

	@SuppressWarnings("unchecked")
	public List<WorkPackageUserAllocation> findByProjectID(int projectID) {
		Query query = getSession()
				.createSQLQuery(
						"select * from work_package_app_user_allocations al, work_package pkg where al.work_package_id=pkg.work_package_number and pkg.project_id=:projectId group by pkg.work_package_number;")
				.addEntity(WorkPackageUserAllocation.class);
		query.setParameter("projectId", projectID);
		List<WorkPackageUserAllocation> workPackages = query.list();
		return workPackages;
	}

}
