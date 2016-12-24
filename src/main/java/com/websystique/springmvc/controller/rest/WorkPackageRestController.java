package com.websystique.springmvc.controller.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.websystique.springmvc.model.WorkPackage;
import com.websystique.springmvc.service.WorkPackageService;

@RestController
@RequestMapping("/workPackage")
public class WorkPackageRestController {

	@Autowired
	WorkPackageService workPackageService;

	/**
	 * This method will get a workPackage with project and workPackage user allocations.
	 */
	@RequestMapping(path = "/getWorkPackage/{id}", method = RequestMethod.GET)
	public WorkPackage getWorkPackage(@PathVariable int id) {

		WorkPackage workpackage = workPackageService.findById(id);
		return workpackage;
	}

}