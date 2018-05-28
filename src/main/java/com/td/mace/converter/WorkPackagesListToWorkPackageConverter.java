package com.td.mace.converter;

import com.td.mace.model.WorkPackage;
import com.td.mace.service.WorkPackageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

/**
 * A converter class used in views to map id's to actual workPackage objects.
 */
@Component
public class WorkPackagesListToWorkPackageConverter implements
		Converter<String, WorkPackage> {

	static final Logger logger = LoggerFactory
			.getLogger(WorkPackagesListToWorkPackageConverter.class);

	@Autowired
	WorkPackageService workPackageService;

	/**
	 * Gets WorkPackage by Id
	 * 
	 * @see org.springframework.core.convert.converter.Converter#convert(java.lang.Object)
	 */
	public WorkPackage convert(String element) {
//		Integer id = Integer.parseInt((String) element);
		Integer id = Integer.parseInt(element);
		WorkPackage workPackagesList = workPackageService.findById(id);
		logger.info("WorkPackages List : {}", workPackagesList);
		return workPackagesList;
	}

}