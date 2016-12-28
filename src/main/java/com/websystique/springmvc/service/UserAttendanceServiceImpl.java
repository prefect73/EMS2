package com.websystique.springmvc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.websystique.springmvc.dao.UserAttendanceDao;
import com.websystique.springmvc.dao.UserDao;
import com.websystique.springmvc.model.UserAttendance;

@Service("userAttendanceService")
@Transactional
public class UserAttendanceServiceImpl implements UserAttendanceService {

	@Autowired
	private UserAttendanceDao dao;

	@Autowired
	private UserDao userDao;

	public UserAttendance findById(int id) {
		return dao.findById(id);
	}

	public UserAttendance findByUserId(String userId) {
		UserAttendance userAttendance = dao.findByUserId(userId);
		return userAttendance;
	}

	@Override
	public UserAttendance findBySSOId(String ssoId) {
		UserAttendance userAttendance = dao.findBySSOId(ssoId);
		return userAttendance;
	}

	public void saveUserAttendance(UserAttendance userAttendance) {
		dao.save(userAttendance);
	}

	/*
	 * Since the method is running with Transaction, No need to call hibernate
	 * update explicitly. Just fetch the entity from db and update it with
	 * proper values within transaction. It will be updated in db once
	 * transaction ends.
	 */
	public void updateUserAttendance(UserAttendance userAttendance) {
		UserAttendance entity = dao.findById(userAttendance.getId());
		if (entity != null) {

			entity.setmJan(userAttendance.getmJan());
			entity.setmFeb(userAttendance.getmFeb());
			entity.setmMar(userAttendance.getmMar());
			entity.setmApr(userAttendance.getmApr());
			entity.setmMay(userAttendance.getmMay());
			entity.setmJun(userAttendance.getmJun());
			entity.setmJul(userAttendance.getmJul());
			entity.setmAug(userAttendance.getmAug());
			entity.setmSep(userAttendance.getmSep());
			entity.setmOct(userAttendance.getmOct());
			entity.setmNov(userAttendance.getmNov());
			entity.setmDec(userAttendance.getmDec());
			entity.setYearName(userAttendance.getYearName());
			entity.setUser(userAttendance.getUser());
		}
	}

	public void deleteUserAttendanceById(int id) {
		dao.deleteById(id);
	}

	public void deleteUserAttendanceByUserId(int id) {
		dao.deleteByUserId(id);
	}

	public List<UserAttendance> findAllUserAttendances() {
		return dao.findAllUserAttendances();
	}

	public List<UserAttendance> findAllUserAttendancesBySSOId(String ssoId) {
		boolean isAdmin = userDao.isAdmin(ssoId);
		if(isAdmin){
			return dao.findAllUserAttendances();
		}
		return dao.findAllUserAttendancesBySSOId(ssoId);
	}
	
	public List<UserAttendance> findAllUserAttendancesUpdated() {
		return dao.findAllUserAttendancesUpdated();
	}
}
