package com.td.mace.wrapper;

import java.util.List;

public class TMWorkPackage {
	private String name;
	private Integer wpUserId;
	private List<Double> hours;
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

	public List<Double> getHours() {
		return hours;
	}

	public void setHours(List<Double> hours) {
		this.hours = hours;
	}

	@Override
	public String toString() {
		return "TMWorkPackage [name=" + name + ", wpUserId=" + wpUserId + ", hours=" + hours + "]";
	}



}
