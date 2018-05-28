package com.td.mace.converter;

import com.td.mace.model.User;
import com.td.mace.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

/**
 * A converter class used in views to map id's to actual user objects.
 */
@Component
public class ProjectLeadsListToUserConverter implements Converter<String, User> {

	static final Logger logger = LoggerFactory
			.getLogger(ProjectLeadsListToUserConverter.class);

	@Autowired
	UserService userService;

	/**
	 * Gets User by Id
	 * 
	 * @see org.springframework.core.convert.converter.Converter#convert(java.lang.Object)
	 */
	public User convert(String element) {
		//Integer id = Integer.parseInt((String) element);
		Integer id = Integer.parseInt(element);
		User leadsList = userService.findById(id);
		logger.info("Project Leads List : {}", leadsList);
		return leadsList;
	}

}