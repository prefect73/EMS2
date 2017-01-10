package com.td.mace.service;

import java.util.List;

import com.td.mace.model.User;


public interface UserService {
	
	User findById(int id);
	
	User findBySSO(String sso);
	
	void saveUser(User user);
	
	void updateUser(User user);
	
	void deleteUserBySSO(String sso);
	
	void deleteUserById(int id);

	List<User> findAllUsers(); 
	
	List<User> findAllUsersByType(String userProfileType); 

	
	boolean isUserSSOUnique(Integer id, String sso);

}