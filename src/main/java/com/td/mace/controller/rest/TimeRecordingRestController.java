package com.td.mace.controller.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.td.mace.service.WorkPackageUserAllocationService;

@RestController
@RequestMapping("/timeRecording")
public class TimeRecordingRestController {

	@Autowired
	WorkPackageUserAllocationService workPackageUserAllocationService;

	@RequestMapping(value = { "/save" }, method = RequestMethod.GET)
	public ResponseEntity<?> saveTimeRecording(@RequestParam(value = "id", required = false) Integer id,
			@RequestParam(value = "hours", required = false) String hours,
			@RequestParam(value = "monthName", required = false) String monthName) {

		workPackageUserAllocationService.saveWorkPackageUserAllocation(id, monthName, hours);
		return new ResponseEntity<>(HttpStatus.OK);
	}
}
