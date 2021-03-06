package com.td.mace.service;

import com.td.mace.model.User;
import com.td.mace.model.WorkPackage;
import com.td.mace.model.WorkPackageUserAllocation;

import java.util.List;

public interface WorkPackageUserAllocationService {

	WorkPackageUserAllocation findById(int id);

	int saveWorkPackageUserAllocation(Integer id, Integer monthIndex, String hours);

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
	
	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsByUserAndYearName(User user, String yearName);

	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsByUserAndWorkPackage(
			WorkPackage workPackage, User user);

	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsBySum();
	
	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsBySum(String ssoId);

	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsBySumOfAllMonths();
	
	List<WorkPackageUserAllocation> getWorkPackageHoursForAllUsers(String workPackageNumber);
	
	List<WorkPackageUserAllocation> findByProjectID(int projectID);

	void updateWorkPackageUserAllocationByYearAndByMonthAndByUser(
			String yearName, String monthName, User user,
			WorkPackageUserAllocation workPackageUserAllocation);

	/*void updateWorkPackageUserAllocationByYearAndByMonthAndByUser(String yearName, String monthName, String monthTotal,String monthCSV, User user,
			WorkPackageUserAllocation workPackageUserAllocation);*/
}