package com.td.mace.controller;

import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.security.authentication.AuthenticationTrustResolver;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.rememberme.PersistentTokenBasedRememberMeServices;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.td.mace.model.User;
import com.td.mace.model.UserAttendance;
import com.td.mace.service.UserAttendanceService;
import com.td.mace.service.UserService;

@Controller
@RequestMapping("/UserAttendance")
@SessionAttributes({ "employeeslist" })
@PropertySource(value = { "classpath:application.properties" })
public class UserAttendanceController {

	@Autowired
	private Environment environment;

	@Autowired
	UserAttendanceService userAttendanceService;

	@Autowired
	UserService userService;

	@Autowired
	MessageSource messageSource;

	@Autowired
	PersistentTokenBasedRememberMeServices persistentTokenBasedRememberMeServices;

	@Autowired
	AuthenticationTrustResolver authenticationTrustResolver;

	/**
	 * This method will list all existing userAttendances.
	 */
	@RequestMapping(value = { "/userAttendanceslist" }, method = RequestMethod.GET)
	public String listUserAttendances(ModelMap model) {
		List<UserAttendance> userAttendances = new ArrayList<UserAttendance>();
		if (getPrincipal() != null) {
			userAttendances = userAttendanceService
					.findAllUserAttendancesBySSOId(getPrincipal());
		} else {
			userAttendances = userAttendanceService.findAllUserAttendances();
		}
		model.addAttribute("defaultLanguage",
				environment.getProperty("default.language"));
		model.addAttribute("userAttendances", userAttendances);
		model.addAttribute("loggedinuser", getPrincipal());

		return "userAttendanceslist";
	}

	/**
	 * This method will provide Users list to views
	 */

	@ModelAttribute("employeeslist")
	public List<User> initializeProjectLeads() {
		return userService.findAllUsers();
	}

	/**
	 * This method will provide the medium to add a new userAttendance.
	 */
	@RequestMapping(value = { "/newuserAttendance" }, method = RequestMethod.GET)
	public String newUserAttendance(ModelMap model) {
		UserAttendance userAttendance = new UserAttendance();
		model.addAttribute("userAttendance", userAttendance);
		model.addAttribute("edit", false);
		model.addAttribute("loggedinuser", getPrincipal());
		return "userAttendance";
	}

	/**
	 * This method will be called on form submission, handling POST request for
	 * saving userAttendance in database. It also validates the userAttendance
	 * input
	 */
	@RequestMapping(value = { "/newuserAttendance" }, method = RequestMethod.POST)
	public String saveUserAttendance(@Valid UserAttendance userAttendance,
			BindingResult result, ModelMap model) {

		if (result.hasErrors()) {
			return "userAttendance";
		}

		/*
		 * Preferred way to achieve uniqueness of field [id] should be
		 * implementing custom @Unique annotation and applying it on field [id]
		 * of Model class [UserAttendance].
		 * 
		 * Below mentioned peace of code [if block] is to demonstrate that you
		 * can fill custom errors outside the validation framework as well while
		 * still using internationalized messages.
		 * 
		 * if (!userAttendanceService.isIdUnique(userAttendance.getId(),
		 * userAttendance.getId())) { FieldError idError = new
		 * FieldError("userAttendance", "id", messageSource.getMessage(
		 * "non.unique.id", new String[] { userAttendance.getId() },
		 * Locale.getDefault())); result.addError(idError); return
		 * "userAttendance"; }
		 */

		userAttendance.setYearName(environment.getProperty("year.name"));
		userAttendanceService.saveUserAttendance(userAttendance);
		// userAttendanceService.updateUserAttendance(userAttendance);

		// model.addAttribute("success", "UserAttendance " +
		// userAttendance.getFirstName() +
		// " "+ userAttendance.getLastName() + " registered successfully");
		// model.addAttribute("loggedinuser", getPrincipal());
		// return "success";
		return "redirect:/UserAttendance/userAttendanceslist";
	}

	/**
	 * This method will provide the medium to update an existing userAttendance.
	 */
	@RequestMapping(value = { "/edit-userAttendance-{id}" }, method = RequestMethod.GET)
	public String editUserAttendance(@PathVariable int id, ModelMap model) {
		UserAttendance userAttendance = userAttendanceService.findById(id);
		model.addAttribute("userAttendance", userAttendance);
		model.addAttribute("edit", true);
		model.addAttribute("loggedinuser", getPrincipal());
		return "userAttendance";
	}

	/**
	 * This method will be called on form submission, handling POST request for
	 * updating userAttendance in database. It also validates the userAttendance
	 * input
	 */
	@RequestMapping(value = { "/edit-userAttendance-{id}" }, method = RequestMethod.POST)
	public String updateUserAttendance(@Valid UserAttendance userAttendance,
			BindingResult result, ModelMap model, @PathVariable Integer id) {

		if (result.hasErrors()) {
			return "userAttendance";
		}

		/*
		 * //Uncomment below 'if block' if you WANT TO ALLOW UPDATING SSO_ID in
		 * UI which is a unique key to a UserAttendance.
		 * if(!userAttendanceService
		 * .isUserAttendanceSSOUnique(userAttendance.getId(),
		 * userAttendance.getId())){ FieldError idError =new
		 * FieldError("userAttendance","id",messageSource.getMessage(
		 * "non.unique.id", new String[]{userAttendance.getId()},
		 * Locale.getDefault())); result.addError(idError); return
		 * "userAttendance"; }
		 */
		userAttendance.setYearName(environment.getProperty("year.name"));
		userAttendanceService.updateUserAttendance(userAttendance);

		// model.addAttribute("success", "UserAttendance " +
		// userAttendance.getFirstName() +
		// " "+ userAttendance.getLastName() + " updated successfully");
		// model.addAttribute("loggedinuser", getPrincipal());
		return "redirect:/UserAttendance/userAttendanceslist";
	}

	/**
	 * This method will delete an userAttendance by it's SSOID value.
	 */
	@RequestMapping(value = { "/delete-userAttendance-{id}" }, method = RequestMethod.GET)
	public String deleteUserAttendance(@PathVariable Integer id) {
		userAttendanceService.deleteUserAttendanceById(id);
		return "redirect:/UserAttendance/userAttendanceslist";
	}

	/**
	 * This method will provide UserAttendance list to views
	 */
	/*
	 * @ModelAttribute("userAttendances") public List<UserAttendance>
	 * initializeProfiles() { return
	 * userAttendanceService.findAllUserAttendances(); }
	 */

	/**
	 * This method returns the principal[user-name] of logged-in user.
	 */
	private String getPrincipal() {
		String userName = null;
		Object principal = SecurityContextHolder.getContext()
				.getAuthentication().getPrincipal();

		if (principal instanceof UserDetails) {
			userName = ((UserDetails) principal).getUsername();
		} else {
			userName = principal.toString();
		}
		return userName;
	}

}