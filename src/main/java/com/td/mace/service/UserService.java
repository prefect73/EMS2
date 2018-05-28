package com.td.mace.service;

import com.td.mace.model.User;

import java.util.List;


public interface UserService {
	
	User findById(int id);
	
	User findBySSO(String sso);
	
	void saveUser(User user);
	
	void updateUser(User user);
	
	void deleteUserBySSO(String sso);
	
	void deleteUserById(int id);

	List<User> findAllUsers(); 
	
	List<User> findAllUsersByType(String userProfileType); 

	List<User> findAllUsersBySSOId(String ssoId);
	
	boolean isUserSSOUnique(Integer id, String sso);
	
	boolean isAdmin(String ssoId);
	
	boolean isAdminOnly(String ssoId);
	
	boolean isTLOnly(String ssoId);

    User findUserByEmail(String userEmail);

	void createPasswordResetTokenForUser(User user, String token);

	String validatePasswordResetToken(long id, String token);

	void changeUserPassword(User user, String password);
}
