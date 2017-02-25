package com.td.mace.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Repository;

import com.td.mace.model.User;
import com.td.mace.model.UserAttendance;
import com.td.mace.model.UserProfile;



@Repository("userDao")
@PropertySource(value = { "classpath:application.properties" })
public class UserDaoImpl extends AbstractDao<Integer, User> implements UserDao {

	static final Logger logger = LoggerFactory.getLogger(UserDaoImpl.class);
	
	@Autowired
	private Environment environment;
	
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
	public List<User> findAllUsersBySSOId(String ssoId) {
		Criteria criteria = createEntityCriteria();
		criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
		// criteria.add(Restrictions.eq("ssoId", ssoId));
		criteria.addOrder(Order.asc("id"));
		List<User> users = (List<User>) criteria
				.list();
		List<User> allowedUsers = new ArrayList<User>();

		for (User user : users) {
			if (user.getSsoId().equalsIgnoreCase(ssoId)) {
				allowedUsers.add(user);
			}
		}
		return allowedUsers;
	}
	
	@SuppressWarnings("unchecked")
	public List<User> findAllUsersByType(String userProfileType) {
		Query query = getSession().createSQLQuery("select au.* from app_user au , app_user_user_profile auup , user_profile up where au.id = auup.user_id and auup.user_profile_id = up.id  and up.type = :type").addEntity(User.class);
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
	
	public void deleteById(int id) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("id", id));
		User user = (User)crit.uniqueResult();
		delete(user);
	}

	public boolean isAdmin (String ssoId){
		boolean isAdmin = false;
		User user = findBySSO(ssoId);
		for(UserProfile userProfile : user.getUserProfiles()){
			if(userProfile.getType().equalsIgnoreCase(environment.getProperty("default.admin.role.title")) || userProfile.getType().equalsIgnoreCase(environment.getProperty("default.project.lead.role.title")) ){
				isAdmin = true;
				return isAdmin;
			}
			
		}
		
		return isAdmin;
	}
	public boolean isAdminOnly (String ssoId){
		boolean isAdmin = false;
		User user = findBySSO(ssoId);
		for(UserProfile userProfile : user.getUserProfiles()){
			if(userProfile.getType().equalsIgnoreCase(environment.getProperty("default.admin.role.title"))  ){
				isAdmin = true;
				return isAdmin;
			}
			
		}
		
		return isAdmin;
	}
	
	public boolean isTLOnly (String ssoId){
		boolean isAdmin = false;
		User user = findBySSO(ssoId);
		for(UserProfile userProfile : user.getUserProfiles()){
			if(userProfile.getType().equalsIgnoreCase(environment.getProperty("default.project.lead.role.title"))  ){
				isAdmin = true;
				return isAdmin;
			}
			
		}
		
		return isAdmin;
	}
}
