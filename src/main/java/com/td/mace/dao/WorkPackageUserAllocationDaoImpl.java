package com.td.mace.dao;

import java.util.ArrayList;
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
						"select id, work_package_id, user_id, sum(total_planned_days) AS total_planned_days, sum(mJan) as mJan, sum(mFeb) as mFeb, sum(mMar) as mMar, sum(mApr) as mApr, sum(mMay) as mMay, sum(mJun) as mJun, sum(mJul) as mJul, sum(mAug) as mAug, sum(mSep) as mSep, sum(mOct) as mOct, sum(mNov) as mNov, sum(mDec) as mDec, sum(emJan) as emJan, sum(emFeb) as emFeb, sum(emMar) as emMar, sum(emApr) as emApr, sum(emMay) as emMay, sum(emJun) as emJun, sum(emJul) as emJul, sum(emAug) as emAug, sum(emSep) as emSep, sum(emOct) as emOct, sum(emNov) as emNov, sum(emDec) as emDec,eemJan,eemFeb,eemMar,eemApr,eemMay,eemJun,eemJul,eemAug,eemSep,eemOct,eemNov,eemDec, Year_Name from work_package_app_user_allocations group by user_id")
				.addEntity(WorkPackageUserAllocation.class);
		List<WorkPackageUserAllocation> workPackageUserAllocationsBySum = query.list();
		return workPackageUserAllocationsBySum;
	}

	public List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsBySumOfAllMonths() {
		Query query = getSession()
				.createSQLQuery(
						"select id, work_package_id, user_id,total_planned_days, mJan, mFeb, mMar, mApr, mMay, mJun, mJul, mAug, mSep, mOct, mNov, mDec, sum(mJan)+sum(mFeb)+sum(mMar)+sum(mApr)+sum(mMay)+sum(mJun)+sum(mJul)+sum(mAug)+sum(mSep)+sum(mOct)+sum(mNov)+sum(mDec) as totalYearHours, Year_Name from work_package_app_user_allocations group by work_package_id;")
				.addEntity(WorkPackageUserAllocation.class);
		List<WorkPackageUserAllocation> workPackageUserAllicationsBySumOfAllMonths = query.list();
		return workPackageUserAllicationsBySumOfAllMonths;
	}

	public List<WorkPackageUserAllocation> getWorkPackageHoursForAllUsers() {
		Query query = getSession()
				.createSQLQuery(
						"select id, work_package_id, user_id,total_planned_days, mJan, mFeb, mMar, mApr, mMay, mJun, mJul, mAug, mSep, mOct, mNov, mDec, Year_Name from work_package_app_user_allocations group by work_package_id;")
				.addEntity(WorkPackageUserAllocation.class);
		@SuppressWarnings("unchecked")
		List<WorkPackageUserAllocation> workPackageIDs = query.list();
		List<WorkPackageUserAllocation> workPackageHoursForAllUsers = new ArrayList<WorkPackageUserAllocation>();

		for (WorkPackageUserAllocation workPackageID : workPackageIDs) {
			Query internalQuery = getSession()
					.createSQLQuery(
							"SELECT id, work_package_id, user_id,SUM(total_planned_days) AS total_planned_days  , SUM(mJan) AS mJan, SUM(mFeb) AS mFeb, SUM(mMar) AS mMar, SUM(mApr) AS mApr, SUM(mMay) AS mMay, SUM(mJun) AS mJun, SUM(mJul) AS mJul, SUM(mAug) AS mAug, SUM(mSep) AS mSep, SUM(mOct) AS mOct, SUM(mNov) AS mNov, SUM(mDec) AS mDec, Year_Name FROM work_package_app_user_allocations WHERE work_package_id=44 GROUP BY user_id")
					.addEntity(WorkPackageUserAllocation.class);
			internalQuery.setParameter("workPackageID",
					workPackageID.getWorkPackage());
			@SuppressWarnings("unchecked")
			List<WorkPackageUserAllocation> workPackageHoursByUserID = internalQuery
					.list();
			workPackageHoursForAllUsers.addAll(workPackageHoursByUserID);
		}

		return workPackageHoursForAllUsers;
	}

	public List<WorkPackageUserAllocation> getTotalWorkPackageHours() {
		Query query = getSession()
				.createSQLQuery(
						"select id, work_package_id, user_id,total_planned_days, mJan, mFeb, mMar, mApr, mMay, mJun, mJul, mAug, mSep, mOct, mNov, mDec, Year_Name from work_package_app_user_allocations group by work_package_id;")
				.addEntity(WorkPackageUserAllocation.class);
		@SuppressWarnings("unchecked")
		List<WorkPackageUserAllocation> workPackageIDs = query.list();
		List<WorkPackageUserAllocation> allWorkPackageTotalHours = new ArrayList<WorkPackageUserAllocation>();

		for (WorkPackageUserAllocation workPackageID : workPackageIDs) {
			Query internalQuery = getSession()
					.createSQLQuery(
							"select id, work_package_id, user_id,SUM(total_planned_days) AS total_planned_days, sum(mJan) as mJan, sum(mFeb) as mFeb, sum(mMar) as mMar, sum(mApr) as mApr, sum(mMay) as mMay, sum(mJun) as mJun, sum(mJul) as mJul, sum(mAug) as mAug, sum(mSep) as mSep, sum(mOct) as mOct, sum(mNov) as mNov, sum(mDec) as mDec, Year_Name from work_package_app_user_allocations where work_package_id=:workPackageID")
					.addEntity(WorkPackageUserAllocation.class);
			internalQuery.setParameter("workPackageID",
					workPackageID.getWorkPackage());
			@SuppressWarnings("unchecked")
			List<WorkPackageUserAllocation> workPackageHours = internalQuery
					.list();
			allWorkPackageTotalHours.addAll(workPackageHours);
		}
		return allWorkPackageTotalHours;
	}

	public List<WorkPackageUserAllocation> getWorkPackageHoursForAllUsers(
			String workPackageNumber) {
		// Query internalQuery =
		// getSession().createSQLQuery("select id, work_package_id, user_id, sum(mJan) as mJan, sum(mFeb) as mFeb, sum(mMar) as mMar, sum(mApr) as mApr, sum(mMay) as mMay, sum(mJun) as mJun, sum(mJul) as mJul, sum(mAug) as mAug, sum(mSep) as mSep, sum(mOct) as mOct, sum(mNov) as mNov, sum(mDec) as mDec, Year_Name from work_package_app_user_allocations where work_package_id=:workPackageID group by user_id;").addEntity(WorkPackageUserAllocation.class);
		Query query = getSession()
				.createSQLQuery(
						"select id, work_package_id, user_id,SUM(total_planned_days) AS total_planned_days, sum(mJan) as mJan, sum(mFeb) as mFeb, sum(mMar) as mMar, sum(mApr) as mApr, sum(mMay) as mMay, sum(mJun) as mJun, sum(mJul) as mJul, sum(mAug) as mAug, sum(mSep) as mSep, sum(mOct) as mOct, sum(mNov) as mNov, sum(mDec) as mDec,sum(emJan) as emJan, sum(emFeb) as emFeb, sum(emMar) as emMar, sum(emApr) as emApr, sum(emMay) as emMay, sum(emJun) as emJun, sum(emJul) as emJul, sum(emAug) as emAug, sum(emSep) as emSep, sum(emOct) as emOct, sum(emNov) as emNov, sum(emDec) as emDec,eemJan,eemFeb,eemMar,eemApr,eemMay,eemJun,eemJul,eemAug,eemSep,eemOct,eemNov,eemDec, Year_Name from work_package_app_user_allocations where work_package_id=(select id from work_package where work_package_number= :workPackageNumber) group by user_id")
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
