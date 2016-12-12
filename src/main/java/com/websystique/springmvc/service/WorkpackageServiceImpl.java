package com.websystique.springmvc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.websystique.springmvc.dao.WorkpackageDao;
import com.websystique.springmvc.model.Workpackage;

@Service("workpackageService")
@Transactional
public class WorkpackageServiceImpl implements WorkpackageService {

	@Autowired
	private WorkpackageDao dao;

	public Workpackage findById(int id) {
		return dao.findById(id);
	}

	public Workpackage findByWorkpackageNumber(String workpackageNumber) {
		Workpackage workpackage = dao.findByWorkpackageNumber(workpackageNumber);
		return workpackage;
	}

	@Override
	public Workpackage findByWorkpackageName(String workpackageName) {
		Workpackage workpackage = dao.findByWorkpackageName(workpackageName);
		return workpackage;
	}

	public void saveWorkpackage(Workpackage workpackage) {
		dao.save(workpackage);
	}

	/*
	 * Since the method is running with Transaction, No need to call hibernate
	 * update explicitly. Just fetch the entity from db and update it with
	 * proper values within transaction. It will be updated in db once
	 * transaction ends.
	 */
	public void updateWorkpackage(Workpackage workpackage) {
		Workpackage entity = dao.findById(workpackage.getId());
		if (entity != null) {
			entity.setWorkpackageNumber(Integer.toString(workpackage.getId()));
			entity.setWorkpackageName(workpackage.getWorkpackageName());
			entity.setOfferedCost(workpackage.getOfferedCost());
			entity.setTotalCost(workpackage.getTotalCost());
			entity.setProject(workpackage.getProject());
		}
	}

	public void deleteWorkpackageById(int id) {
		dao.deleteById(id);
	}

	public List<Workpackage> findAllWorkpackages() {
		return dao.findAllWorkpackages();
	}
}
