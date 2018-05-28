package com.td.mace.dao;

import com.td.mace.model.WorkPackage;
import org.hibernate.Session;

import java.math.BigDecimal;
import java.util.List;


public interface WorkPackageDao {

	WorkPackage findById(int id);
	
	WorkPackage findById(int id, String ssoId);
	
	WorkPackage findByWorkPackageNumber(String workPackageNumber);
	
	WorkPackage findByWorkPackageName(String workPackageName);
	
	void save(WorkPackage WorkPackage);
	
	void deleteById(int id);
	
	public Session getHibernateSession();
	
	List<WorkPackage> findAllWorkPackages();
	
	List<WorkPackage> findAllWorkPackagesByProjectIdAndSsoId(int projectId, String ssoId);
	
	List<WorkPackage> findByProjectID(int projectID);

	List<WorkPackage> findAllWorkPackagesBySSOId(String ssoId);

	void updateWorkPackageCalculatedCost(BigDecimal totalPayments, Integer id);

}

