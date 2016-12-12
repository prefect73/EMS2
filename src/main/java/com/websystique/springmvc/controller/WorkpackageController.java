package com.websystique.springmvc.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
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

import com.websystique.springmvc.model.Project;
import com.websystique.springmvc.model.Workpackage;
import com.websystique.springmvc.service.ProjectService;
import com.websystique.springmvc.service.WorkpackageService;

@Controller
@RequestMapping("/Workpackage")
@SessionAttributes("projectslist")
public class WorkpackageController {

	@Autowired
	WorkpackageService workpackageService;

	@Autowired
	ProjectService projectService;

	/*
	 * @Autowired WorkpackageService workpackageService;
	 */

	@Autowired
	MessageSource messageSource;

	@Autowired
	PersistentTokenBasedRememberMeServices persistentTokenBasedRememberMeServices;

	@Autowired
	AuthenticationTrustResolver authenticationTrustResolver;

	/**
	 * This method will list all existing workpackages.
	 */
	@RequestMapping(value = { "/workpackageslist" }, method = RequestMethod.GET)
	public String listWorkpackages(ModelMap model) {

		List<Workpackage> workpackages = workpackageService
				.findAllWorkpackages();
		model.addAttribute("workpackages", workpackages);
		model.addAttribute("loggedinuser", getPrincipal());
		return "workpackageslist";
	}

	/**
	 * This method will provide Users list to views
	 */
	@ModelAttribute("projectslist")
	public List<Project> initializeProjects() {
		return projectService.findAllProjects();
	}

	/**
	 * This method will provide the medium to add a new workpackage.
	 */
	@RequestMapping(value = { "/newworkpackage" }, method = RequestMethod.GET)
	public String newWorkpackage(ModelMap model) {
		Workpackage workpackage = new Workpackage();
		model.addAttribute("workpackage", workpackage);
		model.addAttribute("edit", false);
		model.addAttribute("loggedinuser", getPrincipal());
		return "workpackage";
	}

	/**
	 * This method will be called on form submission, handling POST request for
	 * saving workpackage in database. It also validates the workpackage input
	 */
	@RequestMapping(value = { "/newworkpackage" }, method = RequestMethod.POST)
	public String saveWorkpackage(@Valid Workpackage workpackage,
			BindingResult result, ModelMap model) {

		if (result.hasErrors()) {
			return "workpackage";
		}

		/*
		 * Preferred way to achieve uniqueness of field [id] should be
		 * implementing custom @Unique annotation and applying it on field [id]
		 * of Model class [Workpackage].
		 * 
		 * Below mentioned peace of code [if block] is to demonstrate that you
		 * can fill custom errors outside the validation framework as well while
		 * still using internationalized messages.
		 * 
		 * if (!workpackageService.isIdUnique(workpackage.getId(),
		 * workpackage.getId())) { FieldError idError = new
		 * FieldError("workpackage", "id", messageSource.getMessage(
		 * "non.unique.id", new String[] { workpackage.getId() },
		 * Locale.getDefault())); result.addError(idError); return
		 * "workpackage"; }
		 */

		workpackageService.saveWorkpackage(workpackage);
		workpackageService.updateWorkpackage(workpackage);

		// model.addAttribute("success", "Workpackage " +
		// workpackage.getFirstName() +
		// " "+ workpackage.getLastName() + " registered successfully");
		// model.addAttribute("loggedinuser", getPrincipal());
		// return "success";
		return "redirect:/Workpackage/workpackageslist";
	}

	/**
	 * This method will provide the medium to update an existing workpackage.
	 */
	@RequestMapping(value = { "/edit-workpackage-{id}" }, method = RequestMethod.GET)
	public String editWorkpackage(@PathVariable int id, ModelMap model) {
		Workpackage workpackage = workpackageService.findById(id);
		model.addAttribute("workpackage", workpackage);
		model.addAttribute("edit", true);
		model.addAttribute("loggedinuser", getPrincipal());
		return "workpackage";
	}

	/**
	 * This method will be called on form submission, handling POST request for
	 * updating workpackage in database. It also validates the workpackage input
	 */
	@RequestMapping(value = { "/edit-workpackage-{id}" }, method = RequestMethod.POST)
	public String updateWorkpackage(@Valid Workpackage workpackage,
			BindingResult result, ModelMap model, @PathVariable Integer id) {

		if (result.hasErrors()) {
			return "workpackage";
		}

		/*
		 * //Uncomment below 'if block' if you WANT TO ALLOW UPDATING SSO_ID in
		 * UI which is a unique key to a Workpackage.
		 * if(!workpackageService.isWorkpackageSSOUnique(workpackage.getId(),
		 * workpackage.getId())){ FieldError idError =new
		 * FieldError("workpackage","id",messageSource.getMessage(
		 * "non.unique.id", new String[]{workpackage.getId()},
		 * Locale.getDefault())); result.addError(idError); return
		 * "workpackage"; }
		 */

		workpackageService.updateWorkpackage(workpackage);

		// model.addAttribute("success", "Workpackage " +
		// workpackage.getFirstName() +
		// " "+ workpackage.getLastName() + " updated successfully");
		// model.addAttribute("loggedinuser", getPrincipal());
		return "redirect:/Workpackage/workpackageslist";
	}

	/**
	 * This method will delete an workpackage by it's SSOID value.
	 */
	@RequestMapping(value = { "/delete-workpackage-{id}" }, method = RequestMethod.GET)
	public String deleteWorkpackage(@PathVariable Integer id) {
		workpackageService.deleteWorkpackageById(id);
		return "redirect:/Workpackage/workpackageslist";
	}

	/**
	 * This method will provide Workpackage list to views
	 */
	/*
	 * @ModelAttribute("workpackages") public List<Workpackage>
	 * initializeProfiles() { return workpackageService.findAllWorkpackages(); }
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