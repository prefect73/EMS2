package com.td.mace.service;

import java.util.List;

import com.td.mace.model.User;
import com.td.mace.model.WorkPackage;
import com.td.mace.model.WorkPackageUserAllocation;

public interface WorkPackageUserAllocationService {

	WorkPackageUserAllocation findById(int id);

	void saveWorkPackageUserAllocation(
			WorkPackageUserAllocation workPackageUserAllocation);

	void updateWorkPackageUserAllocation(
			WorkPackageUserAllocation workPackageUserAllocation);

	void deleteWorkPackageUserAllocationById(int id);

	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocations();

	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsByWorkPackage(
			WorkPackage workPackage);

	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsByUser(
			User user);

	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsByUserAndWorkPackage(
			WorkPackage workPackage, User user);

	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsBySum();

	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsBySumOfAllMonths();

	List<WorkPackageUserAllocation> getWorkPackageHoursForAllUsers();

	List<WorkPackageUserAllocation> getTotalWorkPackageHours();
	
	List<WorkPackageUserAllocation> getWorkPackageHoursForAllUsers(String workPackageNumber);
	
	List<WorkPackageUserAllocation> findByProjectID(int projectID);

}