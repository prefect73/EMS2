package com.td.mace.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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

import com.td.mace.model.Project;
import com.td.mace.model.User;
import com.td.mace.model.UserAttendance;
import com.td.mace.model.WorkPackage;
import com.td.mace.service.ProjectService;
import com.td.mace.service.UserAttendanceService;
import com.td.mace.service.UserService;
import com.td.mace.service.WorkPackageService;
import com.td.mace.service.WorkPackageUserAllocationService;

@Controller
@RequestMapping("/WorkPackage")
@SessionAttributes({ "projectslist", "employeeslist" })
@PropertySource(value = { "classpath:application.properties" })
public class WorkPackageController {

	@Autowired
	private Environment environment;

	@Autowired
	WorkPackageService workPackageService;

	@Autowired
	WorkPackageUserAllocationService workPackageUserAllocationService;

	@Autowired
	ProjectService projectService;

	@Autowired
	UserService userService;

	@Autowired
	UserAttendanceService userAttendanceService;

	@Autowired
	MessageSource messageSource;

	@Autowired
	PersistentTokenBasedRememberMeServices persistentTokenBasedRememberMeServices;

	@Autowired
	AuthenticationTrustResolver authenticationTrustResolver;

	/**
	 * This method will list all existing workPackages.
	 */
	@RequestMapping(value = { "/workPackageslist" }, method = RequestMethod.GET)
	public String listWorkPackages(ModelMap model) {
		
		List<WorkPackage> workPackages = new ArrayList<WorkPackage>();
		if (getPrincipal() != null) {
			workPackages = workPackageService.findAllWorkPackagesBySSOId(getPrincipal());
		} else {
			workPackages = workPackageService.findAllWorkPackages();
		}
		
		
		model.addAttribute("defaultLanguage",
				environment.getProperty("default.language"));
		model.addAttribute("workPackages", workPackages);
		model.addAttribute("loggedinuser", getPrincipal());
		return "workPackageslist";
	}

	/**
	 * This method will provide Projects list to views
	 */

	@ModelAttribute("projectslist")
	public List<Project> initializeProjects() {
		return projectService.findAllProjects();
	}

	/**
	 * This method will provide Users list to views
	 */

	@ModelAttribute("employeeslist")
	public List<User> initializeProjectLeads() {
		return userService.findAllUsers();// change to
	}

	/**
	 * This method will provide the medium to add a new workPackage.
	 */
	@RequestMapping(value = { "/newworkPackage" }, method = RequestMethod.GET)
	public String newWorkPackage(ModelMap model,HttpServletRequest request) {
		WorkPackage workPackage = new WorkPackage();
		
		if(request.getParameter("projectId") != null){
			int projectId = (Integer.parseInt(request.getParameter("projectId")));
			Project project = projectService.findById(projectId);
			workPackage.setProject(project);
		}
		
		model.addAttribute("workPackage", workPackage);
		
		  model.addAttribute("projectslist", projectService.findAllProjects());
		  model.addAttribute("employeeslist", userService.findAllUsers());
		 
		model.addAttribute("userAttendancesUpdated",
				userAttendanceService.findAllUserAttendancesUpdated());
		model.addAttribute("edit", false);
		model.addAttribute("loggedinuser", getPrincipal());
		return "workPackage";
	}

	/**
	 * This method will be called on form submission, handling POST request for
	 * saving workPackage in database. It also validates the workPackage input
	 */
	@RequestMapping(value = { "/newworkPackage" }, method = RequestMethod.POST)
	public String saveWorkPackage(@Valid WorkPackage workPackage,
			BindingResult result, ModelMap model) {

		if (result.hasErrors()) {
			return "workPackage";
		}

		/*
		 * Preferred way to achieve uniqueness of field [id] should be
		 * implementing custom @Unique annotation and applying it on field [id]
		 * of Model class [WorkPackage].
		 * 
		 * Below mentioned peace of code [if block] is to demonstrate that you
		 * can fill custom errors outside the validation framework as well while
		 * still using internationalized messages.
		 * 
		 * if (!workPackageService.isIdUnique(workPackage.getId(),
		 * workPackage.getId())) { FieldError idError = new
		 * FieldError("workPackage", "id", messageSource.getMessage(
		 * "non.unique.id", new String[] { workPackage.getId() },
		 * Locale.getDefault())); result.addError(idError); return
		 * "workPackage"; }
		 */

		/*
		 * for (WorkPackageUserAllocation workPackageUserAllocation :
		 * workPackage .getWorkPackageUserAllocations()) {
		 * workPackageUserAllocation.setYearName(environment
		 * .getProperty("year.name")); }
		 */

		workPackageService.saveWorkPackage(workPackage);
		workPackageService.updateWorkPackage(workPackage);

		// model.addAttribute("success", "WorkPackage " +
		// workPackage.getFirstName() +
		// " "+ workPackage.getLastName() + " registered successfully");
		// model.addAttribute("loggedinuser", getPrincipal());
		// return "success";
		return "redirect:/WorkPackage/workPackageslist";
	}

	/**
	 * This method will provide the medium to update an existing workPackage.
	 */
	@RequestMapping(value = { "/edit-workPackage-{id}" }, method = RequestMethod.GET)
	public String editWorkPackage(@PathVariable int id, ModelMap model) {
		WorkPackage workPackage = workPackageService.findById(id);
		model.addAttribute("workPackage", workPackage);
		
		  model.addAttribute("projectslist", projectService.findAllProjects());
		  model.addAttribute("employeeslist", userService.findAllUsers());
		 
		model.addAttribute("userAttendancesUpdated",
				userAttendanceService.findAllUserAttendancesUpdated());
		model.addAttribute("edit", true);
		model.addAttribute("loggedinuser", getPrincipal());
		return "workPackage";
	}

	/**
	 * This method will be called on form submission, handling POST request for
	 * updating workPackage in database. It also validates the workPackage input
	 */
	@RequestMapping(value = { "/edit-workPackage-{id}" }, method = RequestMethod.POST)
	public String updateWorkPackage(@Valid WorkPackage workPackage,
			BindingResult result, ModelMap model, @PathVariable Integer id) {

		if (result.hasErrors()) {
			model.addAttribute("projectslist", projectService.findAllProjects());
			return "workPackage";
		}

		/*
		 * //Uncomment below 'if block' if you WANT TO ALLOW UPDATING SSO_ID in
		 * UI which is a unique key to a WorkPackage.
		 * if(!workPackageService.isWorkPackageSSOUnique(workPackage.getId(),
		 * workPackage.getId())){ FieldError idError =new
		 * FieldError("workPackage","id",messageSource.getMessage(
		 * "non.unique.id", new String[]{workPackage.getId()},
		 * Locale.getDefault())); result.addError(idError); return
		 * "workPackage"; }
		 */

		/*
		 * for (WorkPackageUserAllocation workPackageUserAllocation :
		 * workPackage.getWorkPackageUserAllocations() ){
		 * workPackageUserAllocation.setWorkPackage(workPackage);
		 * workPackageUserAllocationService
		 * .updateWorkPackageUserAllocation(workPackageUserAllocation); }
		 */

		/*
		 * workPackageUserAllocationService.saveWorkPackageUserAllocation(
		 * workPackage.getWorkPackageUserAllocations());
		 */

		/*
		 * for (WorkPackageUserAllocation workPackageUserAllocation :
		 * workPackage .getWorkPackageUserAllocations()) {
		 * workPackageUserAllocation.setYearName(environment
		 * .getProperty("year.name")); }
		 */

		workPackageService.updateWorkPackage(workPackage);

		// model.addAttribute("success", "WorkPackage " +
		// workPackage.getFirstName() +
		// " "+ workPackage.getLastName() + " updated successfully");
		// model.addAttribute("loggedinuser", getPrincipal());
		return "redirect:/WorkPackage/workPackageslist";
	}

	/**
	 * This method will delete an workPackage by it's SSOID value.
	 */
	@RequestMapping(value = { "/delete-workPackage-{id}" }, method = RequestMethod.GET)
	public String deleteWorkPackage(@PathVariable Integer id) {
		workPackageService.deleteWorkPackageById(id);
		return "redirect:/WorkPackage/workPackageslist";
	}

	/**
	 * This method will provide WorkPackage list to views
	 */
	/*
	 * @ModelAttribute("workPackages") public List<WorkPackage>
	 * initializeProfiles() { return workPackageService.findAllWorkPackages(); }
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