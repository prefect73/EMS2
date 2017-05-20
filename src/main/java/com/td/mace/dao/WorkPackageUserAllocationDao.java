package com.td.mace.dao;

import java.util.List;

import com.td.mace.model.User;
import com.td.mace.model.WorkPackage;
import com.td.mace.model.WorkPackageUserAllocation;


public interface WorkPackageUserAllocationDao {

	WorkPackageUserAllocation findById(int id);
	
	void save(WorkPackageUserAllocation workPackageUserAllocation);
	
	void deleteById(int id);
	
	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocations();
	
	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsByWorkPackage(WorkPackage workPackage);
	
	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsByUser(User user);
	
	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsByUserAndYearName(User user, String yearName);
	
	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsByUserAndWorkPackage(WorkPackage workPackage, User user);
	
	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsBySum();

	List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsBySumOfAllMonths();
	
	List<WorkPackageUserAllocation> getWorkPackageHoursForAllUsers(String workPackageNumber);
	
	List<WorkPackageUserAllocation> findByProjectID(int projectID);

	void updateWorkPackageUserAllocationByYearAndByMonthAndByUser(
			String yearName, String monthName, User user,
			WorkPackageUserAllocation workPackageUserAllocation);
	
	/*void updateWorkPackageUserAllocationByYearAndByMonthAndByUser(String yearName, String monthName, String monthTotal,String monthCSV, User user,
	WorkPackageUserAllocation workPackageUserAllocation);*/
	
	

}

