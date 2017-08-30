package com.td.mace.controller;

public class TimeRecordingDTO {

	private Integer id;
	private Integer[] hours;
	private String monthName;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer[] getHours() {
		return hours;
	}

	public void setHours(Integer[] hours) {
		this.hours = hours;
	}

	public String getMonthName() {
		return monthName;
	}

	public void setMonthName(String monthName) {
		this.monthName = monthName;
	}

}
