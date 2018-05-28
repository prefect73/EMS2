package com.td.mace.service;

import com.td.mace.dao.PasswordResetTokenDao;
import com.td.mace.dao.UserDao;
import com.td.mace.model.PasswordResetToken;
import com.td.mace.model.User;
import com.td.mace.model.UserProfile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;


@Service("userService")
@Transactional
public class UserServiceImpl implements UserService{

	@Autowired
	private UserDao dao;

	@Autowired
    private PasswordEncoder passwordEncoder;

	@Autowired
	private PasswordResetTokenDao passwordTokenRepository;
	
	public User findById(int id) {
		return dao.findById(id);
	}

	public User findBySSO(String sso) {
		User user = dao.findBySSO(sso);
		return user;
	}

	public void saveUser(User user) {
		user.setPassword(passwordEncoder.encode(user.getPassword()));	
		dao.save(user);
	}

	/*
	 * Since the method is running with Transaction, No need to call hibernate update explicitly.
	 * Just fetch the entity from db and update it with proper values within transaction.
	 * It will be updated in db once transaction ends. 
	 */
	public void updateUser(User user) {
		User entity = dao.findById(user.getId());
		if(entity!=null){
			entity.setSsoId(user.getSsoId());
			if(!user.getPassword().equals(entity.getPassword())){
				entity.setPassword(passwordEncoder.encode(user.getPassword()));
			}
			entity.setFirstName(user.getFirstName());
			entity.setLastName(user.getLastName());
			entity.setEmail(user.getEmail());
			entity.setPerDayCost(user.getPerDayCost());
			entity.setUserProfiles(user.getUserProfiles());
			entity.setActive(user.getActive());
		}
	}

	
	public void deleteUserBySSO(String sso) {
		dao.deleteBySSO(sso);
	}
	
	public void deleteUserById(int id) {
		dao.deleteById(id);
	}

	public List<User> findAllUsers() {
		return dao.findAllUsers();
	}
	
	public List<User> findAllUsersBySSOId(String ssoId) {
		boolean isAdmin = dao.isAdminOnly(ssoId);
		if(isAdmin){
			return dao.findAllUsers();
		}
		return dao.findAllUsersBySSOId(ssoId);
	}
	
	
	public List<User> findAllUsersByType(String userProfileType) {
		return dao.findAllUsersByType(userProfileType);
	}

	public boolean isUserSSOUnique(Integer id, String sso) {
		User user = findBySSO(sso);
		return ( user == null || ((id != null) && (user.getId() == id)));
	}
	
	public boolean isAdmin(String ssoId){
		return dao.isAdmin(ssoId);
	}
	
	public boolean isAdminOnly(String ssoId){
		return dao.isAdminOnly(ssoId);
	}
	
	public boolean isTLOnly(String ssoId){
		return dao.isTLOnly(ssoId);
	}

	@Override
	public User findUserByEmail(String userEmail) {
		return dao.findByEmail(userEmail);
	}

	@Override
	public void createPasswordResetTokenForUser(final User user, final String token) {
		final PasswordResetToken myToken = new PasswordResetToken(token, user);
		passwordTokenRepository.save(myToken);
	}

	@Override
	public String validatePasswordResetToken(long id, String token) {
		final PasswordResetToken passToken = passwordTokenRepository.findByToken(token);
		if ((passToken == null) || (passToken.getUser().getId() != id)) {
			return "invalidToken";
		}

		final Calendar cal = Calendar.getInstance();
		if ((passToken.getExpiryDate().getTime() - cal.getTime().getTime()) <= 0) {
			return "expired";
		}

		final User user = passToken.getUser();
		List<GrantedAuthority> userProfiles = new ArrayList<>();
		for(UserProfile userProfile: user.getUserProfiles()){
			userProfiles.add(new SimpleGrantedAuthority(userProfile.getType()));
		}

		final Authentication auth = new UsernamePasswordAuthenticationToken(user, null, userProfiles);
		SecurityContextHolder.getContext().setAuthentication(auth);
		return null;
	}

	@Override
	public void changeUserPassword(User user, String password) {
		user.setPassword(passwordEncoder.encode(password));
		dao.save(user);
	}
}
