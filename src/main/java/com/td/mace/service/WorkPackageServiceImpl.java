package com.td.mace.service;

import java.math.BigDecimal;
import java.util.List;

import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.td.mace.dao.UserDao;
import com.td.mace.dao.WorkPackageDao;
import com.td.mace.model.WorkPackage;
import com.td.mace.model.WorkPackageUserAllocation;

@Service("workPackageService")
@Transactional
public class WorkPackageServiceImpl implements WorkPackageService {

	@Autowired
	private WorkPackageDao dao;
	
	@Autowired
	private UserDao userDao;
		

	public WorkPackage findById(int id) {
		return dao.findById(id);
	}
	
	public WorkPackage findById(int id, String ssoId) {
		return dao.findById(id, ssoId);
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
			entity.setEffectiveCost(getWorkPackageEffectiveCost(workPackage));
			entity.setProject(workPackage.getProject());
			deleteAllWorkPackageUserAllocations(workPackage);
			for (WorkPackageUserAllocation workPackageUserAllocation : workPackage
					.getWorkPackageUserAllocations()) {
				insertWorkPackageUserAllocation(workPackage,
						workPackageUserAllocation);
			}
		}
		updateProjectTotalAndEffectiveCosts(workPackage.getProject().getId());
	}

	private BigDecimal getWorkPackageEffectiveCost(WorkPackage workPackage) {
		BigDecimal workPackageEffectiveCost = new BigDecimal("0.00");
		
		for (WorkPackageUserAllocation workPackageUserAllocation : workPackage
				.getWorkPackageUserAllocations()) {
			BigDecimal userEffectiveCost = new BigDecimal("0.00");
			userEffectiveCost = userEffectiveCost.add(workPackageUserAllocation
					.getEmJan() != null ? workPackageUserAllocation.getEmJan()
					: new BigDecimal("0.00"));
			userEffectiveCost = userEffectiveCost.add(workPackageUserAllocation
					.getEmFeb() != null ? workPackageUserAllocation.getEmFeb()
					: new BigDecimal("0.00"));
			userEffectiveCost = userEffectiveCost.add(workPackageUserAllocation
					.getEmMar() != null ? workPackageUserAllocation.getEmMar()
					: new BigDecimal("0.00"));
			userEffectiveCost = userEffectiveCost.add(workPackageUserAllocation
					.getEmApr() != null ? workPackageUserAllocation.getEmApr()
					: new BigDecimal("0.00"));
			userEffectiveCost = userEffectiveCost.add(workPackageUserAllocation
					.getEmMay() != null ? workPackageUserAllocation.getEmMay()
					: new BigDecimal("0.00"));
			userEffectiveCost = userEffectiveCost.add(workPackageUserAllocation
					.getEmJun() != null ? workPackageUserAllocation.getEmJun()
					: new BigDecimal("0.00"));
			userEffectiveCost = userEffectiveCost.add(workPackageUserAllocation
					.getEmJul() != null ? workPackageUserAllocation.getEmJul()
					: new BigDecimal("0.00"));
			userEffectiveCost = userEffectiveCost.add(workPackageUserAllocation
					.getEmAug() != null ? workPackageUserAllocation.getEmAug()
					: new BigDecimal("0.00"));
			userEffectiveCost = userEffectiveCost.add(workPackageUserAllocation
					.getEmSep() != null ? workPackageUserAllocation.getEmSep()
					: new BigDecimal("0.00"));
			userEffectiveCost = userEffectiveCost.add(workPackageUserAllocation
					.getEmOct() != null ? workPackageUserAllocation.getEmOct()
					: new BigDecimal("0.00"));
			userEffectiveCost = userEffectiveCost.add(workPackageUserAllocation
					.getEmNov() != null ? workPackageUserAllocation.getEmNov()
					: new BigDecimal("0.00"));
			userEffectiveCost = userEffectiveCost.add(workPackageUserAllocation
					.getEmDec() != null ? workPackageUserAllocation.getEmDec()
					: new BigDecimal("0.00"));
			userEffectiveCost = userEffectiveCost
					.multiply(workPackageUserAllocation.getUser() != null && workPackageUserAllocation.getUser().getPerDayCost() != null ? workPackageUserAllocation.getUser().getPerDayCost() : new BigDecimal("0.00"));
			workPackageEffectiveCost = workPackageEffectiveCost.add(userEffectiveCost);
		}

		return workPackageEffectiveCost;
	}

	@SuppressWarnings("unchecked")
	private void updateProjectTotalAndEffectiveCosts(int projectId) {
		BigDecimal projectTotalCost = new BigDecimal("0.00");
		BigDecimal projectEffectiveCost = new BigDecimal("0.00");
		Query getAllWorkPackagesListByProjectId = dao
				.getHibernateSession()
				.createSQLQuery(
						"SELECT * FROM work_package WHERE project_id = :project_id")
				.addEntity(WorkPackage.class);
		getAllWorkPackagesListByProjectId.setParameter("project_id", projectId);

		List<WorkPackage> workPackages = getAllWorkPackagesListByProjectId
				.list();

		for (WorkPackage workPackage : workPackages) {
			projectTotalCost = projectTotalCost.add(workPackage.getTotalCost() != null ? workPackage.getTotalCost() : new BigDecimal("0.00"));
			projectEffectiveCost = projectEffectiveCost.add(workPackage.getEffectiveCost() != null ? workPackage.getEffectiveCost() : new BigDecimal("0.00"));
		}

		Query updateProjectTotalCost = dao
				.getHibernateSession()
				.createSQLQuery(
						"UPDATE project set total_cost = :total_cost ,effective_cost = :effective_cost WHERE id = :project_id");
		updateProjectTotalCost.setParameter("total_cost", projectTotalCost);
		updateProjectTotalCost.setParameter("effective_cost", projectEffectiveCost);
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
							"INSERT INTO work_package_app_user_allocations (work_package_id,  user_id, total_planned_days,  mJan,  mFeb,  mMar,  mApr,  mMay,  mJun,  mJul,  mAug,  mSep,  mOct,  mNov,  mDec, emJan,  emFeb,  emMar,  emApr,  emMay,  emJun,  emJul,  emAug,  emSep,  emOct,  emNov,  emDec, eemJan, eemFeb, eemMar, eemApr, eemMay, eemJun, eemJul, eemAug, eemSep, eemOct, eemNov, eemDec,  YEAR_NAME) VALUES (:work_package_id, :user_id, :total_planned_days, :mJan, :mFeb, :mMar, :mApr, :mMay, :mJun, :mJul, :mAug, :mSep, :mOct, :mNov, :mDec,:emJan, :emFeb, :emMar, :emApr, :emMay, :emJun, :emJul, :emAug, :emSep, :emOct, :emNov, :emDec, :eemJan, :eemFeb, :eemMar, :eemApr, :eemMay, :eemJun, :eemJul, :eemAug, :eemSep, :eemOct, :eemNov, :eemDec, :YEAR_NAME)");
			query.setParameter("work_package_id", workPackage.getId());
			query.setParameter("user_id", workPackageUserAllocation.getUser()
					.getId());
			query.setParameter("total_planned_days", workPackageUserAllocation.getTotalPlannedDays());
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
			query.setParameter("emJan", workPackageUserAllocation.getEmJan());
			query.setParameter("emFeb", workPackageUserAllocation.getEmFeb());
			query.setParameter("emMar", workPackageUserAllocation.getEmMar());
			query.setParameter("emApr", workPackageUserAllocation.getEmApr());
			query.setParameter("emMay", workPackageUserAllocation.getEmMay());
			query.setParameter("emJun", workPackageUserAllocation.getEmJun());
			query.setParameter("emJul", workPackageUserAllocation.getEmJul());
			query.setParameter("emAug", workPackageUserAllocation.getEmAug());
			query.setParameter("emSep", workPackageUserAllocation.getEmSep());
			query.setParameter("emOct", workPackageUserAllocation.getEmOct());
			query.setParameter("emNov", workPackageUserAllocation.getEmNov());
			query.setParameter("emDec", workPackageUserAllocation.getEmDec());
			query.setParameter("eemJan", workPackageUserAllocation.getEemJan());
			query.setParameter("eemFeb", workPackageUserAllocation.getEemFeb());
			query.setParameter("eemMar", workPackageUserAllocation.getEemMar());
			query.setParameter("eemApr", workPackageUserAllocation.getEemApr());
			query.setParameter("eemMay", workPackageUserAllocation.getEemMay());
			query.setParameter("eemJun", workPackageUserAllocation.getEemJun());
			query.setParameter("eemJul", workPackageUserAllocation.getEemJul());
			query.setParameter("eemAug", workPackageUserAllocation.getEemAug());
			query.setParameter("eemSep", workPackageUserAllocation.getEemSep());
			query.setParameter("eemOct", workPackageUserAllocation.getEemOct());
			query.setParameter("eemNov", workPackageUserAllocation.getEemNov());
			query.setParameter("eemDec", workPackageUserAllocation.getEemDec());
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
		BigDecimal workPackageTotalCost = new BigDecimal("0.00");

		for (WorkPackageUserAllocation workPackageUserAllocation : workPackage
				.getWorkPackageUserAllocations()) {
			BigDecimal userTotalCost = new BigDecimal("0.00");
			userTotalCost = userTotalCost.add(workPackageUserAllocation
					.getmJan() != null ? workPackageUserAllocation.getmJan()
					: new BigDecimal("0.00"));
			userTotalCost = userTotalCost.add(workPackageUserAllocation
					.getmFeb() != null ? workPackageUserAllocation.getmFeb()
					: new BigDecimal("0.00"));
			userTotalCost = userTotalCost.add(workPackageUserAllocation
					.getmMar() != null ? workPackageUserAllocation.getmMar()
					: new BigDecimal("0.00"));
			userTotalCost = userTotalCost.add(workPackageUserAllocation
					.getmApr() != null ? workPackageUserAllocation.getmApr()
					: new BigDecimal("0.00"));
			userTotalCost = userTotalCost.add(workPackageUserAllocation
					.getmMay() != null ? workPackageUserAllocation.getmMay()
					: new BigDecimal("0.00"));
			userTotalCost = userTotalCost.add(workPackageUserAllocation
					.getmJun() != null ? workPackageUserAllocation.getmJun()
					: new BigDecimal("0.00"));
			userTotalCost = userTotalCost.add(workPackageUserAllocation
					.getmJul() != null ? workPackageUserAllocation.getmJul()
					: new BigDecimal("0.00"));
			userTotalCost = userTotalCost.add(workPackageUserAllocation
					.getmAug() != null ? workPackageUserAllocation.getmAug()
					: new BigDecimal("0.00"));
			userTotalCost = userTotalCost.add(workPackageUserAllocation
					.getmSep() != null ? workPackageUserAllocation.getmSep()
					: new BigDecimal("0.00"));
			userTotalCost = userTotalCost.add(workPackageUserAllocation
					.getmOct() != null ? workPackageUserAllocation.getmOct()
					: new BigDecimal("0.00"));
			userTotalCost = userTotalCost.add(workPackageUserAllocation
					.getmNov() != null ? workPackageUserAllocation.getmNov()
					: new BigDecimal("0.00"));
			userTotalCost = userTotalCost.add(workPackageUserAllocation
					.getmDec() != null ? workPackageUserAllocation.getmDec()
					: new BigDecimal("0.00"));
			userTotalCost = userTotalCost
					.multiply(workPackageUserAllocation.getUser() != null && workPackageUserAllocation.getUser().getPerDayCost() != null ? workPackageUserAllocation.getUser().getPerDayCost() : new BigDecimal("0.00"));
			workPackageTotalCost = workPackageTotalCost.add(userTotalCost);
		}

		return workPackageTotalCost;
	}

	public void deleteWorkPackageById(int id) {
		WorkPackage workPackage = dao.findById(id);
		deleteAllWorkPackageUserAllocations(workPackage);
		dao.deleteById(id);
		updateProjectTotalAndEffectiveCosts(workPackage.getProject().getId());

	}

	public List<WorkPackage> findAllWorkPackages() {
		return dao.findAllWorkPackages();
	}
	
	public List<WorkPackage> findAllWorkPackagesBySSOId(String ssoId){
			boolean isAdmin = userDao.isAdmin(ssoId);
			if(isAdmin){
				return dao.findAllWorkPackages();
			}
			return dao.findAllWorkPackagesBySSOId(ssoId);
		}
	
	public List<WorkPackage> findByProjectID(int projectID) {
		  return dao.findByProjectID(projectID);  
		 }
}
