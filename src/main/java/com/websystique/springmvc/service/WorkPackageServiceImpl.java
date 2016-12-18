package com.websystique.springmvc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.websystique.springmvc.dao.WorkPackageDao;
import com.websystique.springmvc.model.WorkPackage;

@Service("workPackageService")
@Transactional
public class WorkPackageServiceImpl implements WorkPackageService {

	@Autowired
	private WorkPackageDao dao;

	public WorkPackage findById(int id) {
		return dao.findById(id);
	}

	public WorkPackage findByWorkPackageNumber(String workPackageNumber) {
		WorkPackage workPackage = dao.findByWorkPackageNumber(workPackageNumber);
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
			entity.setTotalCost(workPackage.getTotalCost());
			entity.setProject(workPackage.getProject());
			entity.setWorkPackageUserAllocations(workPackage.getWorkPackageUserAllocations());
		}
	}

	public void deleteWorkPackageById(int id) {
		dao.deleteById(id);
	}

	public List<WorkPackage> findAllWorkPackages() {
		return dao.findAllWorkPackages();
	}
}
