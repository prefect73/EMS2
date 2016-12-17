package com.websystique.springmvc.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.websystique.springmvc.model.UserAttendance;

@Repository("userAttendanceDao")
public class UserAttendanceDaoImpl extends AbstractDao<Integer, UserAttendance>
		implements UserAttendanceDao {

	static final Logger logger = LoggerFactory
			.getLogger(UserAttendanceDaoImpl.class);

	public UserAttendance findById(int id) {
		UserAttendance userAttendance = getByKey(id);

		if (userAttendance != null) {
			Hibernate.initialize(userAttendance.getUser());
		}
		return userAttendance;
	}

	/* Need to work on this */
	public UserAttendance findBySSOId(String ssoId) {
		logger.info("ssoId : {}", ssoId);
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("ssoId", ssoId));
		UserAttendance userAttendance = (UserAttendance) crit.uniqueResult();

		if (userAttendance != null) {
			Hibernate.initialize(userAttendance.getUser());
		}
		return userAttendance;
	}

	/* Need to work on this */
	@Override
	public UserAttendance findByUserId(String userId) {
		logger.info("userId : {}", userId);
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("userId", userId));
		UserAttendance userAttendance = (UserAttendance) crit.uniqueResult();

		if (userAttendance != null) {
			Hibernate.initialize(userAttendance.getUser());
		}
		return userAttendance;
	}

	@SuppressWarnings("unchecked")
	public List<UserAttendance> findAllUserAttendances() {
		Criteria criteria = createEntityCriteria().addOrder(Order.asc("id"));
		// criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);// To
		// avoid
		// duplicates.
		List<UserAttendance> userAttendances = (List<UserAttendance>) criteria
				.list();

		// No need to fetch userAttendanceProfiles since we are not showing them
		// on
		// list page. Let them lazy load.
		// Uncomment below lines for eagerly fetching of userAttendanceProfiles
		// if
		// you want.

		for (UserAttendance userAttendance : userAttendances) {
			Hibernate.initialize(userAttendance.getUser());
		}

		return userAttendances;
	}

	public void save(UserAttendance userAttendance) {
		persist(userAttendance);
	}

	public void deleteById(int id) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("id", id));
		UserAttendance userAttendance = (UserAttendance) crit.uniqueResult();
		delete(userAttendance);
	}

	/* Need to work on this */
	public void deleteByUserId(int id) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("userId", id));
		UserAttendance userAttendance = (UserAttendance) crit.uniqueResult();
		delete(userAttendance);
	}

}
