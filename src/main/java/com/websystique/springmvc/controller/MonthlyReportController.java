package com.websystique.springmvc.controller;

import java.util.List;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.websystique.springmvc.model.UserAttendance;
import com.websystique.springmvc.model.WorkPackageUserAllocation;
import com.websystique.springmvc.service.UserAttendanceService;
import com.websystique.springmvc.service.UserService;
import com.websystique.springmvc.service.WorkPackageService;
import com.websystique.springmvc.service.WorkPackageUserAllocationService;

@Controller
@RequestMapping("/UserAttendance")
@PropertySource(value = { "classpath:application.properties" })
public class MonthlyReportController {

	@Autowired
	WorkPackageService workPackageService;
	
	@Autowired
    private Environment environment;

	@Autowired
	WorkPackageUserAllocationService workPackageUserAllocationService;

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
	@RequestMapping(value = { "/monthlyReport" }, method = RequestMethod.GET)
	public String listMonthlyAttendances(ModelMap model) {

		List<UserAttendance> monthlyAttendances = userAttendanceService
				.findAllUserAttendances();
		List<WorkPackageUserAllocation> workPackageUserAllocationsBySum = workPackageUserAllocationService
				.findAllWorkPackageUserAllocationsBySum();
		model.addAttribute("monthlyAttendances", monthlyAttendances);
		model.addAttribute("defaultLanguage",environment.getProperty("default.language"));
		model.addAttribute("workPackageUserAllocationsBySum",
				workPackageUserAllocationsBySum);
		model.addAttribute("loggedinuser", getPrincipal());
		return "monthlyReport";
	}

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