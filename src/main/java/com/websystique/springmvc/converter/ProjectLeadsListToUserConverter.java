package com.websystique.springmvc.converter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import com.websystique.springmvc.model.User;
import com.websystique.springmvc.service.UserService;

/**
 * A converter class used in views to map id's to actual user objects.
 */
@Component
public class ProjectLeadsListToUserConverter implements Converter<Object, User> {

	static final Logger logger = LoggerFactory
			.getLogger(ProjectLeadsListToUserConverter.class);

	@Autowired
	UserService userService;

	/**
	 * Gets User by Id
	 * 
	 * @see org.springframework.core.convert.converter.Converter#convert(java.lang.Object)
	 */
	public User convert(Object element) {
		Integer id = Integer.parseInt((String) element);
		User leadsList = userService.findById(id);
		logger.info("Project Leads List : {}", leadsList);
		return leadsList;
	}

}