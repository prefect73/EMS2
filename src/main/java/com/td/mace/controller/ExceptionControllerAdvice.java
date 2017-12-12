package com.td.mace.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import javax.servlet.http.HttpServletRequest;

@ControllerAdvice
public class ExceptionControllerAdvice {

	@ExceptionHandler(Exception.class)
	public void handleIOException(HttpServletRequest request, Exception ex) {
		Logger logger = LoggerFactory.getLogger(ex.getClass());
		logger.error(String.format("Cause: %s", ex.getMessage()));
	}
}
