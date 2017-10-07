package com.td.mace.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
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

import com.td.mace.model.User;
import com.td.mace.model.UserAttendance;
import com.td.mace.model.WorkPackageUserAllocation;
import com.td.mace.service.UserAttendanceService;
import com.td.mace.service.UserService;
import com.td.mace.service.WorkPackageService;
import com.td.mace.service.WorkPackageUserAllocationService;

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
		List<UserAttendance> monthlyAttendances = new ArrayList<UserAttendance>();
		List<UserAttendance> monthlyAttendancesToDisplay = new ArrayList<UserAttendance>();
		List<WorkPackageUserAllocation> workPackageUserAllocationsBySum = new ArrayList<WorkPackageUserAllocation>();
		if(getPrincipal() != null){
			if(userService.isAdmin(getPrincipal())){
				
			monthlyAttendances = userAttendanceService.findAllUserAttendances();
			workPackageUserAllocationsBySum = workPackageUserAllocationService.findAllWorkPackageUserAllocationsBySum();
			for(UserAttendance monthlyAttendance : monthlyAttendances){
				for(WorkPackageUserAllocation workPackageUserAllocation :workPackageUserAllocationsBySum){
					User attendanceUser = monthlyAttendance.getUser();
					User allocationUser = workPackageUserAllocation.getUser();
					
					if(monthlyAttendance.getYearName().equalsIgnoreCase(workPackageUserAllocation.getYearName()) && attendanceUser.getId() == allocationUser.getId() ){
						monthlyAttendancesToDisplay.add(monthlyAttendance);
					}
				}
			}
			Collections.sort(monthlyAttendancesToDisplay, new Comparator<UserAttendance>() {
                    @Override
                    public int compare(UserAttendance o1, UserAttendance o2) {
                        if(o1.getUser() == null || o2.getUser() == null){
                            return 0;
                        }
                        return o1.getUser().getFirstName().toLowerCase().compareTo(o2.getUser().getFirstName().toLowerCase());
                    }
                });
			model.addAttribute("monthlyAttendances", monthlyAttendancesToDisplay);
			}else{
                monthlyAttendances = userAttendanceService.findAllUserAttendancesBySSOId(getPrincipal());
                Collections.sort(monthlyAttendances, new Comparator<UserAttendance>() {
                    @Override
                    public int compare(UserAttendance o1, UserAttendance o2) {
                        if(o1.getUser() == null || o2.getUser() == null){
                            return 0;
                        }
                        return o1.getUser().getFirstName().toLowerCase().compareTo(o2.getUser().getFirstName().toLowerCase());
                    }
                });
			workPackageUserAllocationsBySum = workPackageUserAllocationService.findAllWorkPackageUserAllocationsBySum(getPrincipal());
			model.addAttribute("monthlyAttendances", monthlyAttendances);
		}
		}
		
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