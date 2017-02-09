package com.td.mace.dao;

import java.util.List;

import com.td.mace.model.User;


public interface UserDao {

	User findById(int id);
	
	User findBySSO(String sso);
	
	void save(User user);
	
	void deleteBySSO(String sso);
	
	void deleteById(int id);
	
	List<User> findAllUsers();

	List<User> findAllUsersByType(String userProfileType);
	
	boolean isAdmin (String ssoId);
	
	boolean isAdminOnly (String ssoId);
	
	boolean isTLOnly (String ssoId);

	List<User> findAllUsersBySSOId(String ssoId);

}

