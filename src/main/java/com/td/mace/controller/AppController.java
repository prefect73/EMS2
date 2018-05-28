package com.td.mace.controller;

import com.td.mace.model.User;
import com.td.mace.model.UserAttendance;
import com.td.mace.model.UserProfile;
import com.td.mace.service.UserAttendanceService;
import com.td.mace.service.UserProfileService;
import com.td.mace.service.UserService;
import org.hibernate.validator.constraints.Email;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.authentication.AuthenticationTrustResolver;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.rememberme.PersistentTokenBasedRememberMeServices;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.UUID;


@Controller
@RequestMapping("/")
@SessionAttributes("roles")
@PropertySource(value = { "classpath:application.properties" })
public class AppController {

	@Autowired
	UserService userService;
	
	@Autowired
    private Environment environment;
	
	@Autowired
	UserAttendanceService userAttendanceService;
		
	@Autowired
	UserProfileService userProfileService;

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private Environment env;
	
	@Autowired
	MessageSource messageSource;

	@Autowired
	PersistentTokenBasedRememberMeServices persistentTokenBasedRememberMeServices;
	
	@Autowired
	AuthenticationTrustResolver authenticationTrustResolver;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(BigDecimal.class, new BigDecimalEditor());
    }

    @RequestMapping(value = "/user/resetPassword", method = RequestMethod.GET)
    public String forgotPasswordPage(){
    	return "forgotPassword";
	}

	// Reset password
	@RequestMapping(value = "/user/resetPassword", method = RequestMethod.POST)
	public String resetPassword(Model model, final HttpServletRequest request, @RequestParam("email") @Valid @Email String userEmail) {
		final User user = userService.findUserByEmail(userEmail);
		if (user != null) {
			final String token = UUID.randomUUID().toString();
			userService.createPasswordResetTokenForUser(user, token);
			mailSender.send(constructResetTokenEmail(getAppUrl(request), request.getLocale(), token, user));
		}else{
			model.addAttribute("error", true);
		}
		model.addAttribute("email", userEmail);

		return "emailSent";
	}


	@RequestMapping(value = "/user/changePassword", method = RequestMethod.GET)
	public String showChangePasswordPage(Locale locale, Model model, @RequestParam("id") long id, @RequestParam("token") String token) {
		String result = userService.validatePasswordResetToken(id, token);
		if (result != null) {
			model.addAttribute("message", messageSource.getMessage("auth.message." + result, null, locale));
			return "redirect:/login";
		}
		return "redirect:/user/updatePassword";
	}

	@RequestMapping(value = "/user/updatePassword", method = RequestMethod.GET)
	public String showUpdatePasswordPage(){
		return "updatePassword";
	}

	@RequestMapping(value = "/user/updatePassword", method = RequestMethod.POST)
	public String savePassword(String password) {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		userService.changeUserPassword(user, password);
		return "redirect:/";
	}
	
	/**
	 * This method will list all existing users.
	 */
	@RequestMapping(value = {  "/list" }, method = RequestMethod.GET)
	public String listUsers(ModelMap model) {
		
		List<User> users = new ArrayList<User>();
		if (getPrincipal() != null) {
			users = userService.findAllUsersBySSOId(getPrincipal());
		} else {
			users = userService.findAllUsers();
		}

		
		model.addAttribute("users", users);
		model.addAttribute("defaultLanguage",environment.getProperty("default.language"));
		model.addAttribute("loggedinuser", getPrincipal());
		return "userslist";
	}

	/**
	 * This method will provide the medium to add a new user.
	 */
	@RequestMapping(value = { "/newuser" }, method = RequestMethod.GET)
	public String newUser(ModelMap model) {
		User user = new User();
		model.addAttribute("user", user);
		model.addAttribute("edit", false);
		model.addAttribute("loggedinuser", getPrincipal());
		return "registration";
	}

	/**
	 * This method will be called on form submission, handling POST request for
	 * saving user in database. It also validates the user input
	 */
	@RequestMapping(value = { "/newuser" }, method = RequestMethod.POST)
	public String saveUser(@Valid User user, BindingResult result,
			ModelMap model, HttpServletRequest request) {
		UserAttendance userAttendance  = new UserAttendance();
		
		if (result.hasErrors()) {
			return "registration";
		}

		/*
		 * Preferred way to achieve uniqueness of field [sso] should be implementing custom @Unique annotation 
		 * and applying it on field [sso] of Model class [User].
		 * 
		 * Below mentioned peace of code [if block] is to demonstrate that you can fill custom errors outside the validation
		 * framework as well while still using internationalized messages.
		 * 
		 */
		if(!userService.isUserSSOUnique(user.getId(), user.getSsoId())){
			FieldError ssoError =new FieldError("user","ssoId",messageSource.getMessage("non.unique.ssoId", new String[]{user.getSsoId()}, Locale.getDefault()));
		    result.addError(ssoError);
			return "registration";
		}
		
		userService.saveUser(user);
		userAttendance.setUser(user);
		userAttendance.setYearName(environment.getProperty("year.name.default") != null ? environment.getProperty("year.name.default") : "2018" );
		userAttendanceService.saveUserAttendance(userAttendance);

		//model.addAttribute("success", "User " + user.getFirstName() + " "+ user.getLastName() + " registered successfully");
		model.addAttribute("loggedinuser", getPrincipal());
		request.getSession(false).setAttribute("employeeslist", userService.findAllUsers());
		request.getSession(false).setAttribute("projectleadslist", userService.findAllUsersByType(environment.getProperty("default.project.lead.role.title") != null ? environment.getProperty("default.project.lead.role.title") : "Projektleitung" ));//Project Lead
		
		//return "success";
		return "redirect:/list";
	}


	/**
	 * This method will provide the medium to update an existing user.
	 */
	@RequestMapping(value = { "/edit-user-{id}" }, method = RequestMethod.GET)
	public String editUser(@PathVariable int id, ModelMap model) {
		User user = userService.findById(id);
		model.addAttribute("user", user);
		model.addAttribute("edit", true);
		model.addAttribute("loggedinuser", getPrincipal());
		return "registration";
	}
	
	/**
	 * This method will be called on form submission, handling POST request for
	 * updating user in database. It also validates the user input
	 */
	@RequestMapping(value = { "/edit-user-{id}" }, method = RequestMethod.POST)
	public String updateUser(@Valid User user, BindingResult result,
			ModelMap model, @PathVariable String id, HttpServletRequest request) {

		if (result.hasErrors()) {
			return "registration";
		}

		/*//Uncomment below 'if block' if you WANT TO ALLOW UPDATING SSO_ID in UI which is a unique key to a User.
		if(!userService.isUserSSOUnique(user.getId(), user.getSsoId())){
			FieldError ssoError =new FieldError("user","ssoId",messageSource.getMessage("non.unique.ssoId", new String[]{user.getSsoId()}, Locale.getDefault()));
		    result.addError(ssoError);
			return "registration";
		}*/


		userService.updateUser(user);

		//model.addAttribute("success", "User " + user.getFirstName() + " "+ user.getLastName() + " updated successfully");
		model.addAttribute("loggedinuser", getPrincipal());
		request.getSession(false).setAttribute("employeeslist", userService.findAllUsers());
		request.getSession(false).setAttribute("projectleadslist", userService.findAllUsersByType(environment.getProperty("default.project.lead.role.title") != null ? environment.getProperty("default.project.lead.role.title") : "Projektleitung" ));//Project Lead
		
		return "redirect:/list";
	}

	
	/**
	 * This method will delete an user by it's id value.
	 */
	@RequestMapping(value = { "/delete-user-{id}" }, method = RequestMethod.GET)
	public String deleteUser(@PathVariable int id, HttpServletRequest request) {
		userService.deleteUserById(id);
		request.getSession(false).setAttribute("employeeslist", userService.findAllUsers());
		request.getSession(false).setAttribute("projectleadslist", userService.findAllUsersByType(environment.getProperty("default.project.lead.role.title") != null ? environment.getProperty("default.project.lead.role.title") : "Projektleitung" ));//Project Lead
		
		return "redirect:/list";
	}
	

	/**
	 * This method will provide UserProfile list to views
	 */
	@ModelAttribute("roles")
	public List<UserProfile> initializeProfiles() {
		return userProfileService.findAll();
	}
	
	/**
	 * This method handles Access-Denied redirect.
	 */
	@RequestMapping(value = "/Access_Denied", method = RequestMethod.GET)
	public String accessDeniedPage(ModelMap model) {
		model.addAttribute("loggedinuser", getPrincipal());
		return "accessDenied";
	}

	/**
	 * This method handles login GET requests.
	 * If users is already logged-in and tries to goto login page again, will be redirected to list page.
	 */
	@RequestMapping(value = {"/","/login"}, method = RequestMethod.GET)
	public String loginPage() {
		if (isCurrentAuthenticationAnonymous()) {
			return "login";
	    } else {
	    	return "redirect:/list";  
	    }
	}

	/**
	 * This method handles logout requests.
	 * Toggle the handlers if you are RememberMe functionality is useless in your app.
	 */
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String logoutPage (HttpServletRequest request, HttpServletResponse response){
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null){    
			//new SecurityContextLogoutHandler().logout(request, response, auth);
			persistentTokenBasedRememberMeServices.logout(request, response, auth);
			SecurityContextHolder.getContext().setAuthentication(null);
		}
		return "redirect:/login?logout";
	}

	/**
	 * This method returns the principal[user-name] of logged-in user.
	 */
	private String getPrincipal(){
		String userName = null;
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (principal instanceof UserDetails) {
			userName = ((UserDetails)principal).getUsername();
		}else if(principal instanceof User){
			userName = ((User) principal).getSsoId();
		}
		else {
			userName = principal.toString();
		}
		return userName;
	}
	
	/**
	 * This method returns true if users is already authenticated [logged-in], else false.
	 */
	private boolean isCurrentAuthenticationAnonymous() {
	    final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    return authenticationTrustResolver.isAnonymous(authentication);
	}

	private SimpleMailMessage constructResetTokenEmail(String contextPath, Locale locale, String token, User user) {
		String url = contextPath + "/user/changePassword?id=" + user.getId() + "&token=" + token;
		String message = messageSource.getMessage("login.resetPassword", null, locale);
		return constructEmail("Reset Password", message + " \r\n" + url, user);
	}

	private SimpleMailMessage constructEmail(String subject, String body, User user) {
		SimpleMailMessage email = new SimpleMailMessage();
		email.setSubject(subject);
		email.setText(body);
		email.setTo(user.getEmail());
		email.setFrom(env.getProperty("support.email.from"));
		return email;
	}

	private String getAppUrl(HttpServletRequest request) {
		return "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
	}

}