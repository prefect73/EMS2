package com.td.mace.controller;

import com.td.mace.model.Project;
import com.td.mace.model.User;
import com.td.mace.model.WorkPackage;
import com.td.mace.model.WorkPackageUserAllocation;
import com.td.mace.service.ProjectService;
import com.td.mace.service.UserService;
import com.td.mace.service.WorkPackageService;
import com.td.mace.service.WorkPackageUserAllocationService;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.collections4.Predicate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationTrustResolver;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.rememberme.PersistentTokenBasedRememberMeServices;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.math.BigDecimal;
import java.util.List;
import java.util.Locale;

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

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(BigDecimal.class, new BigDecimalEditor());
    }

	/**
	 * This method will list all existing projects.
	 */
	@RequestMapping(value = { "/projectslist" }, method = RequestMethod.GET)
	public String listProjects(
			@RequestParam(value = "openProject", defaultValue = "false", required = false) Boolean openProject,
			@RequestParam(value = "projectId", required = false) Integer projectId,
			@RequestParam(value = "workPackageName", required = false) final String workPackageName,
			ModelMap model) {

		List<Project> projects = projectService.findAllProjects();

		if(workPackageName != null && workPackageName != "") {
			CollectionUtils.filter(projects, new FilterProjects(workPackageName));
		}

        /**
         * 1. calculate work done for each project
         * 2. check if all work packages are finished
         * 3. calculate offered cost
		 * 4. check if project is allocated to current logged user
		 * 5. calculate Calculated Cost
         * 6. calculate payment percentage
         */

        for(Project project : projects){
            Integer projectPercentage = 0;
            List<WorkPackage> workPackages = project.getWorkPackages();
            if(workPackages != null && workPackages.size() > 0){

                // (1)
                BigDecimal projectOfferedCost = new BigDecimal(0);
                for(WorkPackage workPackage : project.getWorkPackages()){

                    // (3)
                    if(workPackage.getOfferedCost() != null){
                        projectOfferedCost = projectOfferedCost.add(workPackage.getOfferedCost());
                    }

                }

                project.setOfferedCost(projectOfferedCost);

				// (2)
                Boolean isWorkPackagesFinished = "Abgeschlossen".equalsIgnoreCase(project.getStatus());
                project.setIsWorkPackagesFinished(isWorkPackagesFinished);
            }

            // (4)
            Boolean isAllocatedToLoggedUser = false;
            for(User user: project.getUsers()){
               String loggedUserName =  getPrincipal();
               if(user.getSsoId().equals(loggedUserName)){
                   isAllocatedToLoggedUser = true;
                   break;
                }
            }

            // (5)
            projectService.updateCalculatedCost(project);

            // (6)
            projectService.calculatePaymentPercentage(project);

            project.setIsAllocatedToLoggedUser(isAllocatedToLoggedUser);
        }

        if(openProject && projectId != null){
            model.put("selectedProject", projectId);
        }

		model.addAttribute("projects", projects);
		model.addAttribute("defaultLanguage",environment.getProperty("default.language"));
		model.addAttribute("loggedinuser", getPrincipal());
		return "projectslist";
	}


	/**
	 * Distribute payment to work packages
	 */
	@RequestMapping(value = "/distributePayments/{projectId}/{percentage}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<Void> distributePaymentsToWorkPackages(@PathVariable("projectId") Integer projectId,
																 @PathVariable("percentage") int percentage){
		workPackageService.distributePaymentPercentage(projectId, percentage);
		return ResponseEntity.ok().build();
	}

	/**
	 * This method will provide the medium to add a new project.
	 */
	@RequestMapping(value = { "/newproject" }, method = RequestMethod.GET)
	public String newProject(ModelMap model) {
		Project project = new Project();
        List<String> customers = projectService.findAllProjectsCustomers();
        model.addAttribute("customers", customers);
		model.addAttribute("project", project);
		model.addAttribute("edit", false);
		model.addAttribute("yearNameStart",environment.getProperty("year.name.start"));
		model.addAttribute("yearNameSelected",environment.getProperty("year.name.default"));
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
			model.addAttribute("yearNameStart",environment.getProperty("year.name.start"));
			model.addAttribute("yearNameEnd",environment.getProperty("year.name.end"));
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
        projectService.updateCalculatedCost(project);
        projectService.calculatePaymentPercentage(project);
        List<String> customers = projectService.findAllProjectsCustomers();
		model.addAttribute("customers", customers);
		model.addAttribute("project", project);
		model.addAttribute("yearNameStart",environment.getProperty("year.name.start"));
		model.addAttribute("yearNameEnd",environment.getProperty("year.name.end"));
		model.addAttribute("edit", true);
		model.addAttribute("loggedinuser", getPrincipal());
		return "project";
	}

	/**
	 * This method will provide Users list to views
	 */
	@ModelAttribute("projectleadslist")
	public List<User> initializeProjectLeads() {
		return userService.findAllUsersByType(environment.getProperty("default.project.lead.role.title") != null ? environment.getProperty("default.project.lead.role.title") : "Projektleitung" );// Project Lead
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
			model.addAttribute("yearNameStart",environment.getProperty("year.name.start"));
			model.addAttribute("yearNameEnd",environment.getProperty("year.name.end"));
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
		
		
		List<Project> projectsList = projectService.findAllProjects();
		
		Project project = new Project();
		List<WorkPackage> workPackages = workPackageService
				.findAllWorkPackages();
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

    @RequestMapping(value = {"/{projectId}/findWorkingPackages"}, method = RequestMethod.GET)
    public String listWorkPackagesInsideProject(@PathVariable("projectId") Integer projectId, ModelMap model) {


	    Project project = projectService.findById(projectId);
	    if(project != null){
            model.addAttribute("projectName", project.getProjectName());
        }

        List<WorkPackageDTO> workPackageDTOList = workPackageService.findAllWorkPackagesByProjectId(projectId);
        model.addAttribute("workpackages", workPackageDTOList);
        return "workPackageTable";
    }

    private Boolean checkIfAllPackagesFinished(List<WorkPackage> workPackages){
        Boolean finished = true;

        for(WorkPackage workPackage: workPackages){
            if(workPackage.getStatus() == null || !workPackage.getStatus().equals("Abgeschlossen")){
                return false;
            }
        }

        return finished;
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

	private class FilterProjects implements Predicate<Project> {

		private String workPackageName;

		public FilterProjects(String workPackageName) {
			this.workPackageName = workPackageName;
		}

		@Override
		public boolean evaluate(Project project) {
			List<WorkPackage> workPackages = project.getWorkPackages();
			if (workPackages != null) {
				for (WorkPackage workPackage : workPackages) {
					if (workPackage.getWorkPackageName() != null
							&& workPackage.getWorkPackageName().toLowerCase().contains(workPackageName.toLowerCase())) {
						return true;
					}
				}
			}
			return false;
		}
	}

}
