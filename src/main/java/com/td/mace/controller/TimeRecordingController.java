package com.td.mace.controller;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.joda.time.LocalDate;
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
import org.springframework.util.ReflectionUtils;
import org.springframework.validation.BindingResult;
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
import com.td.mace.wrapper.ProjectsWrapper;
import com.td.mace.wrapper.TMProject;
import com.td.mace.wrapper.TMWorkPackage;

import utils.DayOfWeek;

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
	 * @throws IllegalAccessException 
	 * @throws IllegalArgumentException 
	 */
	@RequestMapping(value = { "/timeRecording-{yearName}-{monthName}-{showAll}" }, method = RequestMethod.GET)
	public String getTimeRecordings(@PathVariable String yearName, @PathVariable String monthName ,@PathVariable String showAll , ModelMap model) throws IllegalArgumentException, IllegalAccessException {

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
		model.addAttribute("projectsWrapper",projectsWrapper);
		/*model.addAttribute("projects",projectsByYearNameAndUser);*/
		model.addAttribute("loggedinuser", getPrincipal());

		// Top page table
		LocalDate month = new LocalDate(Integer.parseInt(yearName), Integer.parseInt(monthName) + 1, 1);

		// get first day of the selected month
		LocalDate firstDay = month.withDayOfMonth(1);
		// get first day of next month
		LocalDate nextMonthFirstDay = firstDay.plusMonths(1);

		Map<String, List<?>> monthSummary = new HashMap<>();
		List<String> tableHeader = new ArrayList<>();
		List<Double> summaryTableBody = new ArrayList<>();
		while (firstDay.isBefore(nextMonthFirstDay)) {
			tableHeader.add(firstDay.getDayOfMonth() + ". " + DayOfWeek.getDayName(firstDay.getDayOfWeek()));
			firstDay = firstDay.plusDays(1);
		}

		HashMap<String, String> monthNames = new HashMap<String, String>();
		monthNames.put("0", "Jan");
		monthNames.put("1", "Feb");
		monthNames.put("2", "Mar");
		monthNames.put("3", "Apr");
		monthNames.put("4", "May");
		monthNames.put("5", "Jun");
		monthNames.put("6", "Jul");
		monthNames.put("7", "Aug");
		monthNames.put("8", "Sep");
		monthNames.put("9", "Oct");
		monthNames.put("10", "Nov");
		monthNames.put("11", "Dec");

		monthSummary.put("tableHeader", tableHeader);
		monthSummary.put("tableBody", summaryTableBody);
		model.addAttribute("monthSummary", monthSummary);
		List<TMProject> tmProjects = new ArrayList<>();
		for(Project project: projectsWrapper.getProjects()) {
			TMProject tmProject = new TMProject();
			List<TMWorkPackage> tmWorkPackages = new ArrayList<>();
			for(WorkPackage workPackage: project.getWorkPackages()) {
				TMWorkPackage tmWorkPackage = new TMWorkPackage();
				tmWorkPackage.setName(workPackage.getWorkPackageName());
				
				
				WorkPackageUserAllocation userAllocation = workPackage.getWorkPackageUserAllocations().get(0);
				tmWorkPackage.setWpUserId(userAllocation.getId());
				
				Field field = ReflectionUtils.findField(userAllocation.getClass(), "eem" + monthNames.get(monthName));
				ReflectionUtils.makeAccessible(field);
				String value = (String) field.get(userAllocation);
				
				if(value.length() > 0 && value.contains(",")) {					
					List<String> foundHours = new ArrayList<>(tableHeader.size());
					foundHours.addAll(Arrays.asList(value.split(",")));
					List<String> hours = new ArrayList<>();
					
					// if string has more numbers that days in month
					if (foundHours.size() > tableHeader.size()) {
						hours = foundHours.subList(0, tableHeader.size());
					} else if (foundHours.size() < tableHeader.size()) {
						// if list of hours from db its not for all days in the months
						// then set this days as 0
						int missingHours = tableHeader.size() - foundHours.size();
						String[] missingHoursArr = new String[missingHours];
						for (int j = 0; j < missingHours; j++) {
							missingHoursArr[j] = "0";
						}
						foundHours.addAll(new ArrayList<>(Arrays.asList(missingHoursArr)));
						hours = foundHours;
					} else {
						hours = foundHours;
					}
					List<Double> doubleHours = new ArrayList<>();
					for (String s : hours) {
						try {
							doubleHours.add(Double.parseDouble(s));
						} catch (Exception exception) {
							doubleHours.add(0d);
						}
					}

					tmWorkPackage.setHours(doubleHours);
				} else {
					Double[] hours = new Double[tableHeader.size()];
					Arrays.fill(hours, 0d);
					tmWorkPackage.setHours(Arrays.asList(hours));
				}
				
				

				tmWorkPackages.add(tmWorkPackage);
			}
			
			tmProject.setName(project.getProjectName());
			tmProject.setWorkPackages(tmWorkPackages);
			
			tmProjects.add(tmProject);
			
		}

		// Calculate total hours summary

		for (TMProject project : tmProjects) {
			List<Double> projectTotalHours = new ArrayList<>();

			for (int i = 0; i < tableHeader.size(); i++) {
				double wpSummary = 0d;
				for (TMWorkPackage tmWorkPackage : project.getWorkPackages()) {
					wpSummary += tmWorkPackage.getHours().get(i);
				}
				projectTotalHours.add(wpSummary);

			}

			project.setTotalHours(projectTotalHours);

		}

		for (int i = 0; i < tableHeader.size(); i++) {
			double totalMonthSummary = 0;
			for (TMProject project : tmProjects) {
				totalMonthSummary += project.getTotalHours().get(i);
			}
			summaryTableBody.add(totalMonthSummary);
		}
		
		// sort projects
		
		Collections.sort(tmProjects, new Comparator<TMProject>() {
			@Override
			public int compare(TMProject o1, TMProject o2) {
				return o1.getName().compareTo(o2.getName());
			}

		});


		model.addAttribute("tmProjects",tmProjects);
		return "timeRecording";
	}
	
	/**
	 * POST
	 */
	@RequestMapping(value = { "/timeRecording-{yearName}-{monthName}-{showAll}" }, method = RequestMethod.POST)
	 public String postTimeRecordings(@PathVariable String yearName, @PathVariable String monthName ,@PathVariable String showAll , 
	   @Valid ProjectsWrapper projectsWrapper,
	      BindingResult result, ModelMap model, HttpServletRequest request) {

		
	  User user = null;
	  List<Project> projects = new ArrayList<Project>();
	  if (getPrincipal() != null) {
		user = userService.findBySSO(getPrincipal());
		for (Project project : projectsWrapper.getProjects()) {
			for (WorkPackage workPackage : project.getWorkPackages()) {
				for (WorkPackageUserAllocation workPackageUserAllocation : workPackage.getWorkPackageUserAllocations()) {
					workPackageUserAllocationService.updateWorkPackageUserAllocationByYearAndByMonthAndByUser(yearName, monthName, user, workPackageUserAllocation);
					workPackageService.updateWorkPackageForTimeRecording(workPackageUserAllocation.getWorkPackage(), user);				   
					
				}
			}
		}
		  
	  }
	  projects = projectService.findAllProjectsByYearNameAndUser(user, yearName, showAll);
	  projectsWrapper.setProjects(projects);
	  model.addAttribute("defaultLanguage",environment.getProperty("default.language"));
	  model.addAttribute("selectedYear", yearName);
	  model.addAttribute("selectedMonth", monthName);
	  model.addAttribute("showAll",showAll );
	  model.addAttribute("yearNameStart",environment.getProperty("year.name.start"));
	  model.addAttribute("yearNameEnd",environment.getProperty("year.name.end"));
	  model.addAttribute("projectsWrapper",projectsWrapper);
	  /*model.addAttribute("projects",projects);*/
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