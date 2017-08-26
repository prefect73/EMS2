package com.td.mace.wrapper;

import java.util.List;

public class TMProject {
	
	private String name;
	
	private List<TMWorkPackage> workPackages;

	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<TMWorkPackage> getWorkPackages() {
		return workPackages;
	}

	public void setWorkPackages(List<TMWorkPackage> workPackages) {
		this.workPackages = workPackages;
	}
	
	

}
