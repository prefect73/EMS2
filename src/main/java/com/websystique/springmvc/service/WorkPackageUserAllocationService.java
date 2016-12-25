package com.websystique.springmvc.service;

import java.util.List;

import com.websystique.springmvc.model.User;
import com.websystique.springmvc.model.WorkPackage;
import com.websystique.springmvc.model.WorkPackageUserAllocation;

public interface WorkPackageUserAllocationService {

	WorkPackageUserAllocation findById(int id);

	void saveWorkPackageUserAllocation(WorkPackageUserAllocation workPackageUserAllocation);
	
	void updateWorkPackageUserAllocation(WorkPackageUserAllocation workPackageUserAllocation);

	void deleteWorkPackageUserAllocationById(int id);

	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocations();

	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsByWorkPackage(
			WorkPackage workPackage);

	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsByUser(
			User user);

	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsByUserAndWorkPackage(
			WorkPackage workPackage, User user);

}