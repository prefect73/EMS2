package com.websystique.springmvc.service;

import java.math.BigDecimal;
import java.util.List;

import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.websystique.springmvc.dao.WorkPackageDao;
import com.websystique.springmvc.model.WorkPackage;
import com.websystique.springmvc.model.WorkPackageUserAllocation;

@Service("workPackageService")
@Transactional
public class WorkPackageServiceImpl implements WorkPackageService {

	@Autowired
	private WorkPackageDao dao;

	public WorkPackage findById(int id) {
		return dao.findById(id);
	}

	public WorkPackage findByWorkPackageNumber(String workPackageNumber) {
		WorkPackage workPackage = dao
				.findByWorkPackageNumber(workPackageNumber);
		return workPackage;
	}

	@Override
	public WorkPackage findByWorkPackageName(String workPackageName) {
		WorkPackage workPackage = dao.findByWorkPackageName(workPackageName);
		return workPackage;
	}

	public void saveWorkPackage(WorkPackage workPackage) {
		dao.save(workPackage);
	}

	/*
	 * Since the method is running with Transaction, No need to call hibernate
	 * update explicitly. Just fetch the entity from db and update it with
	 * proper values within transaction. It will be updated in db once
	 * transaction ends.
	 */
	public void updateWorkPackage(WorkPackage workPackage) {
		WorkPackage entity = dao.findById(workPackage.getId());
		if (entity != null) {
			entity.setWorkPackageNumber(Integer.toString(workPackage.getId()));
			entity.setWorkPackageName(workPackage.getWorkPackageName());
			entity.setOfferedCost(workPackage.getOfferedCost());
			entity.setTotalCost(getWorkPackageTotalCost(workPackage));
			entity.setProject(workPackage.getProject());
			deleteAllWorkPackageUserAllocations(workPackage);
			for (WorkPackageUserAllocation workPackageUserAllocation : workPackage
					.getWorkPackageUserAllocations()) {
				insertWorkPackageUserAllocation(workPackage,
						workPackageUserAllocation);
			}
		}
		updateProjectTotalCost(workPackage.getProject().getId());
	}

	@SuppressWarnings("unchecked")
	private void updateProjectTotalCost(int projectId) {
		BigDecimal projectTotalCost = new BigDecimal(0);
		Query getAllWorkPackagesListByProjectId = dao
				.getHibernateSession()
				.createSQLQuery(
						"SELECT * FROM work_package WHERE project_id = :project_id")
				.addEntity(WorkPackage.class);
		getAllWorkPackagesListByProjectId.setParameter("project_id", projectId);

		List<WorkPackage> workPackages = getAllWorkPackagesListByProjectId
				.list();

		for (WorkPackage workPackage : workPackages) {
			projectTotalCost = projectTotalCost
					.add(workPackage.getTotalCost() != null ? workPackage
							.getTotalCost() : new BigDecimal(0));
		}

		Query updateProjectTotalCost = dao
				.getHibernateSession()
				.createSQLQuery(
						"UPDATE project set total_cost = :total_cost WHERE id = :project_id");
		updateProjectTotalCost.setParameter("total_cost", projectTotalCost);
		updateProjectTotalCost.setParameter("project_id", projectId);
		updateProjectTotalCost.executeUpdate();

	}

	private void insertWorkPackageUserAllocation(WorkPackage workPackage,
			WorkPackageUserAllocation workPackageUserAllocation) {
		if (workPackageUserAllocation != null
				&& workPackageUserAllocation.getUser() != null) {
			Query query = dao
					.getHibernateSession()
					.createSQLQuery(
							"INSERT INTO work_package_app_user_allocations (work_package_id,  user_id,  mJan,  mFeb,  mMar,  mApr,  mMay,  mJun,  mJul,  mAug,  mSep,  mOct,  mNov,  mDec,  YEAR_NAME) VALUES (:work_package_id, :user_id, :mJan, :mFeb, :mMar, :mApr, :mMay, :mJun, :mJul, :mAug, :mSep, :mOct, :mNov, :mDec, :YEAR_NAME)");
			query.setParameter("work_package_id", workPackage.getId());
			query.setParameter("user_id", workPackageUserAllocation.getUser()
					.getId());
			query.setParameter("mJan", workPackageUserAllocation.getmJan());
			query.setParameter("mFeb", workPackageUserAllocation.getmFeb());
			query.setParameter("mMar", workPackageUserAllocation.getmMar());
			query.setParameter("mApr", workPackageUserAllocation.getmApr());
			query.setParameter("mMay", workPackageUserAllocation.getmMay());
			query.setParameter("mJun", workPackageUserAllocation.getmJun());
			query.setParameter("mJul", workPackageUserAllocation.getmJul());
			query.setParameter("mAug", workPackageUserAllocation.getmAug());
			query.setParameter("mSep", workPackageUserAllocation.getmSep());
			query.setParameter("mOct", workPackageUserAllocation.getmOct());
			query.setParameter("mNov", workPackageUserAllocation.getmNov());
			query.setParameter("mDec", workPackageUserAllocation.getmDec());
			query.setParameter("YEAR_NAME",
					workPackageUserAllocation.getYearName());
			query.executeUpdate();
		}
	}

	private void deleteAllWorkPackageUserAllocations(WorkPackage workPackage) {
		Query deleteQuery = dao
				.getHibernateSession()
				.createSQLQuery(
						"DELETE FROM work_package_app_user_allocations WHERE work_package_id = :work_package_id ");
		deleteQuery.setParameter("work_package_id", workPackage.getId());
		deleteQuery.executeUpdate();
	}

	private BigDecimal getWorkPackageTotalCost(WorkPackage workPackage) {
		BigDecimal workPackageTotalCost = new BigDecimal(0);

		for (WorkPackageUserAllocation workPackageUserAllocation : workPackage
				.getWorkPackageUserAllocations()) {
			BigDecimal userTotalCost = new BigDecimal(0);
			userTotalCost = userTotalCost.add(workPackageUserAllocation
					.getmJan() != null ? workPackageUserAllocation.getmJan()
					: new BigDecimal(0));
			userTotalCost = userTotalCost.add(workPackageUserAllocation
					.getmFeb() != null ? workPackageUserAllocation.getmFeb()
					: new BigDecimal(0));
			userTotalCost = userTotalCost.add(workPackageUserAllocation
					.getmMar() != null ? workPackageUserAllocation.getmMar()
					: new BigDecimal(0));
			userTotalCost = userTotalCost.add(workPackageUserAllocation
					.getmApr() != null ? workPackageUserAllocation.getmApr()
					: new BigDecimal(0));
			userTotalCost = userTotalCost.add(workPackageUserAllocation
					.getmMay() != null ? workPackageUserAllocation.getmMay()
					: new BigDecimal(0));
			userTotalCost = userTotalCost.add(workPackageUserAllocation
					.getmJun() != null ? workPackageUserAllocation.getmJun()
					: new BigDecimal(0));
			userTotalCost = userTotalCost.add(workPackageUserAllocation
					.getmJul() != null ? workPackageUserAllocation.getmJul()
					: new BigDecimal(0));
			userTotalCost = userTotalCost.add(workPackageUserAllocation
					.getmAug() != null ? workPackageUserAllocation.getmAug()
					: new BigDecimal(0));
			userTotalCost = userTotalCost.add(workPackageUserAllocation
					.getmSep() != null ? workPackageUserAllocation.getmSep()
					: new BigDecimal(0));
			userTotalCost = userTotalCost.add(workPackageUserAllocation
					.getmOct() != null ? workPackageUserAllocation.getmOct()
					: new BigDecimal(0));
			userTotalCost = userTotalCost.add(workPackageUserAllocation
					.getmNov() != null ? workPackageUserAllocation.getmNov()
					: new BigDecimal(0));
			userTotalCost = userTotalCost.add(workPackageUserAllocation
					.getmDec() != null ? workPackageUserAllocation.getmDec()
					: new BigDecimal(0));
			userTotalCost = userTotalCost
					.multiply(workPackageUserAllocation.getUser() != null && workPackageUserAllocation.getUser().getPerDayCost() != null ? workPackageUserAllocation.getUser().getPerDayCost() : new BigDecimal(0));
			workPackageTotalCost = workPackageTotalCost.add(userTotalCost);
		}

		return workPackageTotalCost;
	}

	public void deleteWorkPackageById(int id) {
		WorkPackage workPackage = dao.findById(id);
		deleteAllWorkPackageUserAllocations(workPackage);
		dao.deleteById(id);
		updateProjectTotalCost(workPackage.getProject().getId());

	}

	public List<WorkPackage> findAllWorkPackages() {
		return dao.findAllWorkPackages();
	}
	
	public List<WorkPackage> findByProjectID(int projectID) {
		  return dao.findByProjectID(projectID);  
		 }
}
