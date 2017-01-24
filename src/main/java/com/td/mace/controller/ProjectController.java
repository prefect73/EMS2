package com.td.mace.controller;

import java.util.List;
import java.util.Locale;

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
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.td.mace.model.Project;
import com.td.mace.model.User;
import com.td.mace.model.WorkPackage;
import com.td.mace.model.WorkPackageUserAllocation;
import com.td.mace.service.ProjectService;
import com.td.mace.service.UserService;
import com.td.mace.service.WorkPackageService;
import com.td.mace.service.WorkPackageUserAllocationService;

@Controller
@RequestMapping("/Project")
@SessionAttributes("projectleadslist")
@PropertySource(value = { "classpath:application.properties" })
public class ProjectController {

	@Autowired
	Environment environment;

	@Autowired
	ProjectService projectService;

	@Autowired
	UserService userService;

	@Autowired
	WorkPackageService workPackageService;

	@Autowired
	WorkPackageUserAllocationService workPackageUserAllocationService;

	@Autowired
	MessageSource messageSource;

	@Autowired
	PersistentTokenBasedRememberMeServices persistentTokenBasedRememberMeServices;

	@Autowired
	AuthenticationTrustResolver authenticationTrustResolver;

	/**
	 * This method will list all existing projects.
	 */
	@RequestMapping(value = { "/projectslist" }, method = RequestMethod.GET)
	public String listProjects(ModelMap model) {

		List<Project> projects = projectService.findAllProjects();
		model.addAttribute("projects", projects);
		model.addAttribute("defaultLanguage",environment.getProperty("default.language"));
		model.addAttribute("loggedinuser", getPrincipal());
		return "projectslist";
	}

	/**
	 * This method will provide the medium to add a new project.
	 */
	@RequestMapping(value = { "/newproject" }, method = RequestMethod.GET)
	public String newProject(ModelMap model) {
		Project project = new Project();
		model.addAttribute("project", project);
		model.addAttribute("edit", false);
		model.addAttribute("yearNameStart",environment.getProperty("year.name.start"));
		model.addAttribute("yearNameEnd",environment.getProperty("year.name.end"));
		model.addAttribute("loggedinuser", getPrincipal());
		return "project";
	}

	/**
	 * This method will be called on form submission, handling POST request for
	 * saving project in database. It also validates the project input
	 */
	@RequestMapping(value = { "/newproject" }, method = RequestMethod.POST)
	public String saveProject(@Valid Project project, BindingResult result,
			ModelMap model, HttpServletRequest request) {

		if (result.hasErrors()) {
			return "project";
		}

		/*
		 * Preferred way to achieve uniqueness of field [projectNumber] should
		 * be implementing custom @Unique annotation and applying it on field
		 * [projectNumber] of Model class [Project].
		 * 
		 * Below mentioned peace of code [if block] is to demonstrate that you
		 * can fill custom errors outside the validation framework as well while
		 * still using internationalized messages.
		 */
		if (!projectService.isProjectNumberUnique(project.getId(),
				project.getProjectNumber())) {
			FieldError projectNumberError = new FieldError("project",
					"projectNumber", messageSource.getMessage(
							"non.unique.projectNumber",
							new String[] { project.getProjectNumber() },
							Locale.getDefault()));
			result.addError(projectNumberError);
			return "project";
		}

		if (!projectService.isProjectNameUnique(project.getId(),
				project.getProjectName())) {
			FieldError projectNameError = new FieldError("project",
					"projectName", messageSource.getMessage(
							"non.unique.projectName",
							new String[] { project.getProjectName() },
							Locale.getDefault()));
			result.addError(projectNameError);
			return "project";
		}

		projectService.saveProject(project);
		projectService.updateProject(project);

		// model.addAttribute("success", "Project " + project.getFirstName() +
		// " "+ project.getLastName() + " registered successfully");
		model.addAttribute("loggedinuser", getPrincipal());
		// return "success";
		request.getSession(false).setAttribute("projectslist",
				projectService.findAllProjects());
		return "redirect:/Project/projectslist";
	}

	/**
	 * This method will provide the medium to update an existing project.
	 */
	@RequestMapping(value = { "/edit-project-{projectNumber}" }, method = RequestMethod.GET)
	public String editProject(@PathVariable String projectNumber, ModelMap model) {
		Project project = projectService.findByProjectNumber(projectNumber);
		model.addAttribute("project", project);
		model.addAttribute("edit", true);
		model.addAttribute("loggedinuser", getPrincipal());
		return "project";
	}

	/**
	 * This method will provide Users list to views
	 */
	@ModelAttribute("projectleadslist")
	public List<User> initializeProjectLeads() {
		return userService.findAllUsersByType("Projektleitung");// Project Lead
	}

	/**
	 * This method will be called on form submission, handling POST request for
	 * updating project in database. It also validates the project input
	 */
	@RequestMapping(value = { "/edit-project-{projectNumber}" }, method = RequestMethod.POST)
	public String updateProject(@Valid Project project, BindingResult result,
			ModelMap model, @PathVariable String projectNumber,
			HttpServletRequest request) {

		if (result.hasErrors()) {
			return "project";
		}

		/*
		 * //Uncomment below 'if block' if you WANT TO ALLOW UPDATING SSO_ID in
		 * UI which is a unique key to a Project.
		 * if(!projectService.isProjectSSOUnique(project.getId(),
		 * project.getProjectNumber())){ FieldError projectNumberError =new
		 * FieldError("project","projectNumber",messageSource.getMessage(
		 * "non.unique.projectNumber", new String[]{project.getProjectNumber()},
		 * Locale.getDefault())); result.addError(projectNumberError); return
		 * "project"; }
		 */

		projectService.updateProject(project);

		// model.addAttribute("success", "Project " + project.getFirstName() +
		// " "+ project.getLastName() + " updated successfully");
		model.addAttribute("loggedinuser", getPrincipal());
		request.getSession(false).setAttribute("projectslist",
				projectService.findAllProjects());
		return "redirect:/Project/projectslist";
	}

	/**
	 * This method will delete an project by it's SSOID value.
	 */
	@RequestMapping(value = { "/delete-project-{projectNumber}" }, method = RequestMethod.GET)
	public String deleteProject(@PathVariable String projectNumber,
			HttpServletRequest request) {
		projectService.deleteProjectByProjectNumber(projectNumber);
		request.getSession(false).setAttribute("projectslist",
				projectService.findAllProjects());
		return "redirect:/Project/projectslist";
	}

	@RequestMapping(value = { "/projectReport" }, method = RequestMethod.GET)
	public String listProjectReports(ModelMap model) {
		List<Project> projectsList = projectService.findAllProjects();
		Project project = new Project();
		model.addAttribute("project", project);
		model.addAttribute("projectsList", projectsList);
		model.addAttribute("loggedinuser", getPrincipal());
		return "projectReport";
	}

	@RequestMapping(value = { "/projectReport-{projectNumber}-{workPackageName}" }, method = RequestMethod.GET)
	public String listProjectReports(@PathVariable int projectNumber,
			@PathVariable String workPackageName, ModelMap model) {
		// public String listProjectReports(@RequestParam(value =
		// "projectNamesDropDownSelectedValue", required = false) Integer
		// projectNumber, @RequestParam(value = "selectedWorkPackageName",
		// required = false) String workPackageName, ModelMap model) {
		/*
		 * if(workPackageName == null) { // true when landed first time on the
		 * project report page workPackageName = " "; }
		 */
		List<Project> projectsList = projectService.findAllProjects();
		/*
		 * Project defaultProject = new Project();defaultProject.setProjectName(
		 * "--------------------------Wählen--------------------------");
		 * projectsList.add(0,defaultProject); defaultProject.setOfferedCost(new
		 * BigDecimal(0)); defaultProject.setTotalCost(new BigDecimal(0));
		 */

		Project project = new Project();
		List<WorkPackage> workPackages = workPackageService
				.findAllWorkPackages();
		// List<WorkPackage> workPackagesByProjectID =
		// workPackageService.findByProjectID(projectNumber);
		// List<WorkPackageUserAllocation> workPackageHoursForAllUsers =
		// workPackageUserAllocationService.findAllWorkPackageUserAllocationsByWorkPackage(workPackage);
		List<WorkPackageUserAllocation> workPackagesByProjectID = workPackageUserAllocationService
				.findByProjectID(projectNumber);
		if (projectNumber > 0) {
			project = workPackagesByProjectID != null
					&& workPackagesByProjectID.size() > 0 ? workPackagesByProjectID
					.get(0).getWorkPackage().getProject()
					: new Project();
		}
		List<WorkPackageUserAllocation> workPackageHoursForAllUsers = workPackageUserAllocationService
				.getWorkPackageHoursForAllUsers(workPackageName);
		model.addAttribute("project", project);
		model.addAttribute("defaultLanguage",environment.getProperty("default.language"));
		model.addAttribute("yearNameStart",environment.getProperty("year.name.start"));
		model.addAttribute("yearNameEnd",environment.getProperty("year.name.end"));
		model.addAttribute("selectedProjectNumber", projectNumber);
		model.addAttribute("projectsList", projectsList);
		model.addAttribute("workPackages", workPackages);
		model.addAttribute("workPackagesByProjectID", workPackagesByProjectID);
		model.addAttribute("workPackageHoursForAllUsers",
				workPackageHoursForAllUsers);
		model.addAttribute("loggedinuser", getPrincipal());
		return "projectReport";
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
