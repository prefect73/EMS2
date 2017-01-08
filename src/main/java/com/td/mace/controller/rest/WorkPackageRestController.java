package com.td.mace.controller.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.UriComponentsBuilder;

import com.td.mace.model.WorkPackage;
import com.td.mace.service.WorkPackageService;

@RestController
@RequestMapping("/workPackage")
public class WorkPackageRestController {

	@Autowired
	WorkPackageService workPackageService;

	/*
	*//**
	 * This method will get a workPackage with project and workPackage
	 * workPackage allocations.
	 */
	/*
	 * @RequestMapping(path = "/getWorkPackage/{id}", method =
	 * RequestMethod.GET) public WorkPackage getWorkPackage(@PathVariable int
	 * id) {
	 * 
	 * WorkPackage workpackage = workPackageService.findById(id); return
	 * workpackage; }
	 */

	// -------------------Retrieve All
	// WorkPackages--------------------------------------------------------

	@RequestMapping(value = "/workPackage/", method = RequestMethod.GET)
	public ResponseEntity<List<WorkPackage>> listAllWorkPackages() {
		List<WorkPackage> workPackages = workPackageService
				.findAllWorkPackages();
		if (workPackages.isEmpty()) {
			return new ResponseEntity<List<WorkPackage>>(HttpStatus.NO_CONTENT);// You
																				// many
																				// decide
																				// to
																				// return
																				// HttpStatus.NOT_FOUND
		}
		return new ResponseEntity<List<WorkPackage>>(workPackages,
				HttpStatus.OK);
	}

	// -------------------Retrieve Single
	// WorkPackage--------------------------------------------------------

	@RequestMapping(value = "/workPackage/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<WorkPackage> getWorkPackage(
			@PathVariable("id") int id) {
		System.out.println("Fetching WorkPackage with id " + id);
		WorkPackage workPackage = workPackageService.findById(id);
		if (workPackage == null) {
			System.out.println("WorkPackage with id " + id + " not found");
			return new ResponseEntity<WorkPackage>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<WorkPackage>(workPackage, HttpStatus.OK);
	}

	// -------------------Create a
	// WorkPackage--------------------------------------------------------

	@RequestMapping(value = "/workPackage/", method = RequestMethod.POST)
	public ResponseEntity<Void> createWorkPackage(
			@RequestBody WorkPackage workPackage, UriComponentsBuilder ucBuilder) {
		System.out.println("Creating WorkPackage " + workPackage.getWorkPackageName());

		/*if (workPackageService.isWorkPackageExist(workPackage)) {
			System.out.println("A WorkPackage with name "
					+ workPackage.getName() + " already exist");
			return new ResponseEntity<Void>(HttpStatus.CONFLICT);
		}*/

		workPackageService.saveWorkPackage(workPackage);

		HttpHeaders headers = new HttpHeaders();
		headers.setLocation(ucBuilder.path("/workPackage/{id}")
				.buildAndExpand(workPackage.getId()).toUri());
		return new ResponseEntity<Void>(headers, HttpStatus.CREATED);
	}

	// ------------------- Update a WorkPackage
	// --------------------------------------------------------

	@RequestMapping(value = "/workPackage/{id}", method = RequestMethod.PUT)
	public ResponseEntity<WorkPackage> updateWorkPackage(
			@PathVariable("id") int id, @RequestBody WorkPackage workPackage) {
		System.out.println("Updating WorkPackage " + id);

		WorkPackage currentWorkPackage = workPackageService.findById(id);

		if (currentWorkPackage == null) {
			System.out.println("WorkPackage with id " + id + " not found");
			return new ResponseEntity<WorkPackage>(HttpStatus.NOT_FOUND);
		}

		currentWorkPackage.setWorkPackageNumber(Integer.toString(workPackage.getId()));
		currentWorkPackage.setWorkPackageName(workPackage.getWorkPackageName());
		currentWorkPackage.setOfferedCost(workPackage.getOfferedCost());
		currentWorkPackage.setTotalCost(workPackage.getTotalCost());
		currentWorkPackage.setProject(workPackage.getProject());
		currentWorkPackage.setWorkPackageUserAllocations(workPackage.getWorkPackageUserAllocations());

		workPackageService.updateWorkPackage(currentWorkPackage);
		return new ResponseEntity<WorkPackage>(currentWorkPackage,
				HttpStatus.OK);
	}

	// ------------------- Delete a WorkPackage
	// --------------------------------------------------------

	@RequestMapping(value = "/workPackage/{id}", method = RequestMethod.DELETE)
	public ResponseEntity<WorkPackage> deleteWorkPackage(
			@PathVariable("id") int id) {
		System.out.println("Fetching & Deleting WorkPackage with id " + id);

		WorkPackage workPackage = workPackageService.findById(id);
		if (workPackage == null) {
			System.out.println("Unable to delete. WorkPackage with id " + id
					+ " not found");
			return new ResponseEntity<WorkPackage>(HttpStatus.NOT_FOUND);
		}
		workPackageService.deleteWorkPackageById(id);
		return new ResponseEntity<WorkPackage>(HttpStatus.NO_CONTENT);
	}

}