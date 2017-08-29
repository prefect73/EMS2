package com.td.mace.wrapper;

import java.util.List;

public class TMWorkPackage {
	private String name;
	private Integer wpUserId;
	private List<Integer> hours;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public Integer getWpUserId() {
		return wpUserId;
	}

	public void setWpUserId(Integer wpUserId) {
		this.wpUserId = wpUserId;
	}

	public List<Integer> getHours() {
		return hours;
	}

	public void setHours(List<Integer> hours) {
		this.hours = hours;
	}



}
