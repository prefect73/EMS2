package com.td.mace.dao;

import java.util.List;

import org.hibernate.Session;

import com.td.mace.model.WorkPackage;


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

}

