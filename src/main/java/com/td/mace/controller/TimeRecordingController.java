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

import com.td.mace.model.Project;
import com.td.mace.model.User;
import com.td.mace.model.WorkPackageUserAllocation;
import com.td.mace.service.ProjectService;
import com.td.mace.service.UserService;
import com.td.mace.service.WorkPackageService;
import com.td.mace.service.WorkPackageUserAllocationService;
import com.td.mace.wrapper.ProjectsWrapper;

@Controller
@RequestMapping("/TimeRecordingReport")
@SessionAttributes({ "projectslist" })
@PropertySource(value = { "classpath:application.properties" })
public class TimeRecordingController {

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
	MessageSource messageSource;

	@Autowired
	PersistentTokenBasedRememberMeServices persistentTokenBasedRememberMeServices;

	@Autowired
	AuthenticationTrustResolver authenticationTrustResolver;
	
	/**
	 * GET
	 */
	@RequestMapping(value = { "/timeRecording-{yearName}-{monthName}-{showAll}" }, method = RequestMethod.GET)
	public String getTimeRecordings(@PathVariable String yearName, @PathVariable String monthName ,@PathVariable String showAll , ModelMap model) {

		List<Project> projectsByYearNameAndUser = new ArrayList<Project>();
		ProjectsWrapper projectsWrapper = new ProjectsWrapper();
		
		if (getPrincipal() != null) {
			User user = userService.findBySSO(getPrincipal());
			projectsByYearNameAndUser = projectService.findAllProjectsByYearNameAndUser(user, yearName, showAll);
			projectsWrapper.setProjects(projectsByYearNameAndUser);
		}
		
		model.addAttribute("defaultLanguage",environment.getProperty("default.language"));
		model.addAttribute("selectedYear", yearName);
		model.addAttribute("selectedMonth", monthName);
		model.addAttribute("showAll", showAll);
		model.addAttribute("yearNameStart",environment.getProperty("year.name.start"));
		model.addAttribute("yearNameEnd",environment.getProperty("year.name.end"));
		model.addAttribute("projects",projectsByYearNameAndUser);
		model.addAttribute("loggedinuser", getPrincipal());
		return "timeRecording";
	}
	
	/**
	 * POST
	 */
	@RequestMapping(value = { "/timeRecording-{yearName}-{monthName}-{showAll}" }, method = RequestMethod.POST)
	 public String postTimeRecordings(@PathVariable String yearName, @PathVariable String monthName ,@PathVariable String showAll , 
	   @Valid WorkPackageUserAllocation workPackageUserAllocation,
	      BindingResult result, ModelMap model) {

		
	  User user = null;
	  List<Project> projects = new ArrayList<Project>();
	  if (getPrincipal() != null) {
		user = userService.findBySSO(getPrincipal());
		workPackageUserAllocationService.updateWorkPackageUserAllocationByYearAndByMonthAndByUser(yearName, monthName, user, workPackageUserAllocation);
		workPackageService.updateWorkPackageForTimeRecording(workPackageUserAllocation.getWorkPackage(), user);				   
		  
	  }
	  projects = projectService.findAllProjectsByYearNameAndUser(user, yearName, showAll);
	  model.addAttribute("defaultLanguage",environment.getProperty("default.language"));
	  model.addAttribute("selectedYear", yearName);
	  model.addAttribute("selectedMonth", monthName);
	  model.addAttribute("showAll",showAll );
	  model.addAttribute("yearNameStart",environment.getProperty("year.name.start"));
	  model.addAttribute("yearNameEnd",environment.getProperty("year.name.end"));
	  model.addAttribute("projects",projects);
	  model.addAttribute("loggedinuser", getPrincipal());
	  model.addAttribute("userId",user.getId());
	  return "timeRecording";
	 }
	
	

	/**
	 * This method will provide Projects list to views
	 */

	@ModelAttribute("projectslist")
	public List<Project> initializeProjects() {
		return projectService.findAllProjects();
	}

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