package com.websystique.springmvc.dao;

import java.util.List;

import com.websystique.springmvc.model.User;
import com.websystique.springmvc.model.WorkPackage;
import com.websystique.springmvc.model.WorkPackageUserAllocation;


public interface WorkPackageUserAllocationDao {

	WorkPackageUserAllocation findById(int id);
	
	void save(WorkPackageUserAllocation workPackageUserAllocation);
	
	void deleteById(int id);
	
	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocations();
	
	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsByWorkPackage(WorkPackage workPackage);
	
	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsByUser(User user);
	
	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsByUserAndWorkPackage(WorkPackage workPackage, User user);
	
	public List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsBySum();

}

