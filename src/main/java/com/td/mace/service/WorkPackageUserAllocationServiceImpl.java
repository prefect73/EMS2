package com.td.mace.service;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ReflectionUtils;

import com.td.mace.dao.WorkPackageUserAllocationDao;
import com.td.mace.model.User;
import com.td.mace.model.WorkPackage;
import com.td.mace.model.WorkPackageUserAllocation;

@Service("workPackageUserAllocationService")
@Transactional
public class WorkPackageUserAllocationServiceImpl implements
		WorkPackageUserAllocationService {

	@Autowired
	private WorkPackageUserAllocationDao dao;

	public WorkPackageUserAllocation findById(int id) {
		return dao.findById(id);
	}

	public void saveWorkPackageUserAllocation(
			WorkPackageUserAllocation workPackageUserAllocation) {
		dao.save(workPackageUserAllocation);
	}


	/*
	 * Since the method is running with Transaction, No need to call hibernate
	 * update explicitly. Just fetch the entity from db and update it with
	 * proper values within transaction. It will be updated in db once
	 * transaction ends.
	 */
	public void updateWorkPackageUserAllocation(
			WorkPackageUserAllocation workPackageUserAllocation) {
		WorkPackageUserAllocation entity = dao
				.findById(workPackageUserAllocation.getId());
		if (entity != null) {
			entity.setTotalPlannedDays(workPackageUserAllocation.getTotalPlannedDays());
			entity.setmJan(workPackageUserAllocation.getmJan());
			entity.setmFeb(workPackageUserAllocation.getmFeb());
			entity.setmMar(workPackageUserAllocation.getmMar());
			entity.setmApr(workPackageUserAllocation.getmApr());
			entity.setmMay(workPackageUserAllocation.getmMay());
			entity.setmJun(workPackageUserAllocation.getmJun());
			entity.setmJul(workPackageUserAllocation.getmJul());
			entity.setmAug(workPackageUserAllocation.getmAug());
			entity.setmSep(workPackageUserAllocation.getmSep());
			entity.setmOct(workPackageUserAllocation.getmOct());
			entity.setmNov(workPackageUserAllocation.getmNov());
			entity.setmDec(workPackageUserAllocation.getmDec());
			entity.setYearName(workPackageUserAllocation.getYearName());
			entity.setWorkPackage(workPackageUserAllocation.getWorkPackage());
			entity.setUser(workPackageUserAllocation.getUser());
		}
	}

	public void deleteWorkPackageUserAllocationById(int id) {
		dao.deleteById(id);
	}

	@Override
	public List<WorkPackageUserAllocation> findAllWorkPackageUserAllocations() {
		return dao.findAllWorkPackageUserAllocations();
	}

	@Override
	public List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsByWorkPackage(
			WorkPackage workPackage) {
		return dao.findAllWorkPackageUserAllocationsByWorkPackage(workPackage);
	}

	@Override
	public List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsByUser(
			User user) {
		return dao.findAllWorkPackageUserAllocationsByUser(user);
	}

	@Override
	public List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsByUserAndWorkPackage(
			WorkPackage workPackage, User user) {
		return dao.findAllWorkPackageUserAllocationsByUserAndWorkPackage(
				workPackage, user);
	}

	public List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsBySum() {
		return dao.findAllWorkPackageUserAllocationsBySum();
	}
	
	public List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsBySum(String ssoId) {
		List<WorkPackageUserAllocation> allowedWorkpackageUserAllocatins = new ArrayList<WorkPackageUserAllocation>();
		
		for(WorkPackageUserAllocation workPackageUserAllocation : dao.findAllWorkPackageUserAllocationsBySum()){
			User user = workPackageUserAllocation.getUser();
			if(user.getSsoId().equalsIgnoreCase(ssoId)){
				allowedWorkpackageUserAllocatins.add(workPackageUserAllocation);
			}
		}
		 
		
		return allowedWorkpackageUserAllocatins;
	}

	@Override
	public List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsBySumOfAllMonths() {
		return dao.findAllWorkPackageUserAllocationsBySumOfAllMonths();
	}

	@Override
	public List<WorkPackageUserAllocation> getWorkPackageHoursForAllUsers(
			String workPackageNumber) {
		return dao.getWorkPackageHoursForAllUsers(workPackageNumber);
	}

	@Override
	public List<WorkPackageUserAllocation> findByProjectID(int projectID) {		
		return dao.findByProjectID(projectID);
	}

	@Override
	public List<WorkPackageUserAllocation> findAllWorkPackageUserAllocationsByUserAndYearName(
			User user, String yearName) {
		return dao.findAllWorkPackageUserAllocationsByUserAndYearName(user, yearName);
	}

	@Override
	public void updateWorkPackageUserAllocationByYearAndByMonthAndByUser(
			String yearName, String monthName, User user,
			WorkPackageUserAllocation workPackageUserAllocation) {
			dao.updateWorkPackageUserAllocationByYearAndByMonthAndByUser(
					yearName,monthName,user,
					workPackageUserAllocation);
	}

	@Override
	public int saveWorkPackageUserAllocation(Integer id, Integer monthIndex, String hours) {
		WorkPackageUserAllocation workPackageUserAllocation  = dao.findById(id);
		
		HashMap<Integer, String> monthNames = new HashMap<Integer, String>();
		monthNames.put(0, "Jan");
		monthNames.put(1, "Feb");
		monthNames.put(2, "Mar");
		monthNames.put(3, "Apr");
		monthNames.put(4, "May");
		monthNames.put(5, "Jun");
		monthNames.put(6, "Jul");
		monthNames.put(7, "Aug");
		monthNames.put(8, "Sep");
		monthNames.put(9, "Oct");
		monthNames.put(10, "Nov");
		monthNames.put(11, "Dec");
		
		// calculate monthly total
		double monthTotalSummary = 0d;

		String[] hoursStringArr = hours.split(",");

		for (int i = 0; i < hoursStringArr.length; i++) {
			monthTotalSummary += Double.parseDouble(hoursStringArr[i]);
		}

		Field field = ReflectionUtils.findField(workPackageUserAllocation.getClass(),
				"eem" + monthNames.get(monthIndex));
		Field monthTotalField = ReflectionUtils.findField(workPackageUserAllocation.getClass(),
				"em" + monthNames.get(monthIndex));
		ReflectionUtils.makeAccessible(field);
		ReflectionUtils.makeAccessible(monthTotalField);
		try {
			field.set(workPackageUserAllocation, hours);
			monthTotalField.set(workPackageUserAllocation, new BigDecimal(monthTotalSummary));
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		dao.save(workPackageUserAllocation);

		return 1;
	}

	/*@Override
	public void updateWorkPackageUserAllocationByYearAndByMonthAndByUser(String yearName, String monthName, String monthTotal,String monthCSV, User user,
			WorkPackageUserAllocation workPackageUserAllocation) {
		dao.updateWorkPackageUserAllocationByYearAndByMonthAndByUser(yearName, monthName, monthTotal,monthCSV, user,
				workPackageUserAllocation);
	}*/
	
	

}
