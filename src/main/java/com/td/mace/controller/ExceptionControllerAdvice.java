package com.td.mace.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class ExceptionControllerAdvice {
	@ExceptionHandler(Exception.class)
	public void handleIOException(HttpServletRequest request, Exception ex) {
		ex.fillInStackTrace();
	}
}
