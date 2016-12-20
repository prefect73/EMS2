package com.websystique.springmvc.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.websystique.springmvc.model.User;
import com.websystique.springmvc.model.UserProfile;



@Repository("userDao")
public class UserDaoImpl extends AbstractDao<Integer, User> implements UserDao {

	static final Logger logger = LoggerFactory.getLogger(UserDaoImpl.class);
	
	public User findById(int id) {
		User user = getByKey(id);
		if(user!=null){
			Hibernate.initialize(user.getUserProfiles());
		}
		return user;
	}

	public User findBySSO(String sso) {
		logger.info("SSO : {}", sso);
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("ssoId", sso));
		User user = (User)crit.uniqueResult();
		if(user!=null){
			Hibernate.initialize(user.getUserProfiles());
		}
		return user;
	}

	@SuppressWarnings("unchecked")
	public List<User> findAllUsers() {
		Criteria criteria = createEntityCriteria().addOrder(Order.asc("firstName"));
		criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);//To avoid duplicates.
		List<User> users = (List<User>) criteria.list();
		
		// No need to fetch userProfiles since we are not showing them on list page. Let them lazy load. 
		// Uncomment below lines for eagerly fetching of userProfiles if you want.
		
		for(User user : users){
			Hibernate.initialize(user.getUserProfiles());
		}
		return users;
	}
	
	@SuppressWarnings("unchecked")
	public List<User> findAllUsersByType(String userProfileType) {
		Query query = getSession().createSQLQuery("SELECT au.* FROM app_user au , app_user_user_profile auup , user_profile up WHERE au.id = auup.user_id AND auup.user_profile_id = up.id  AND up.type = :type").addEntity(User.class);
		query.setParameter("type", userProfileType);
		List<User> users = query.list();
		return users;
	}

	public void save(User user) {
		persist(user);
	}

	public void deleteBySSO(String sso) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("ssoId", sso));
		User user = (User)crit.uniqueResult();
		delete(user);
	}

	public boolean isAdmin (String ssoId){
		boolean isAdmin = false;
		User user = findBySSO(ssoId);
		for(UserProfile userProfile : user.getUserProfiles()){
			if(userProfile.getType().equalsIgnoreCase("Admin")){
				isAdmin = true;
				return isAdmin;
			}
			
		}
		
		return isAdmin;
	}
}
