package com.td.mace.wrapper;

import java.util.List;

public class TMProject {
	
	private String name;
	
	private List<Double> totalHours;

	private List<TMWorkPackage> workPackages;

	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Double> getTotalHours() {
		return totalHours;
	}

	public void setTotalHours(List<Double> totalHours) {
		this.totalHours = totalHours;
	}

	public List<TMWorkPackage> getWorkPackages() {
		return workPackages;
	}

	public void setWorkPackages(List<TMWorkPackage> workPackages) {
		this.workPackages = workPackages;
	}
	
	

}
