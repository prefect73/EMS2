package com.td.mace.controller.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.td.mace.controller.TimeRecordingDTO;
import com.td.mace.service.WorkPackageUserAllocationService;

@RestController
@RequestMapping("/timeRecording")
public class TimeRecordingRestController {

	@Autowired
	WorkPackageUserAllocationService workPackageUserAllocationService;

	@RequestMapping(value = {
			"/save" }, method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody ResponseEntity<HttpStatus> saveTimeRecordingPost(
			@RequestBody List<TimeRecordingDTO> recordingDTOs) {
		for (TimeRecordingDTO dto : recordingDTOs) {
			workPackageUserAllocationService.saveWorkPackageUserAllocation(dto.getId(), dto.getMonthIndex(),
					dto.getHours());
		}
		return new ResponseEntity<>(HttpStatus.OK);
	}
}
