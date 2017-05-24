package com.td.mace.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name = "work_package")
public class WorkPackage implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	// @NotEmpty
	@Column(name = "work_package_number", unique = true, nullable = true)
	private String workPackageNumber;

	@NotEmpty
	@Column(name = "work_package_name", nullable = false)
	private String workPackageName;

	@Column(name = "offered_cost", precision = 10, scale = 2)
	private BigDecimal offeredCost = new BigDecimal("0.00");
	

	@Column(name = "calculated_cost", precision = 10, scale = 2)
	private BigDecimal calculatedCost = new BigDecimal("0.00");

	@Column(name = "total_cost", precision = 10, scale = 2)
	private BigDecimal totalCost =  new BigDecimal("0.00");
	
	@Column(name = "effective_cost", precision = 10, scale = 2)
	private BigDecimal effectiveCost=  new BigDecimal("0.00");

	
	@Column(name = "work_done_in_percent", nullable = false)
	private Integer workDoneInPercent;
	
	
	@Column(name = "status", nullable = false)
	private String status;
	
	@ManyToOne(optional = false, fetch = FetchType.EAGER)
	@JoinColumn(name = "project_id")
	private Project project;

	@OneToMany(mappedBy = "workPackage")
	private List<WorkPackageUserAllocation> workPackageUserAllocations = new ArrayList<WorkPackageUserAllocation>();

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getWorkPackageNumber() {
		return workPackageNumber;
	}

	public void setWorkPackageNumber(String workPackageNumber) {
		this.workPackageNumber = workPackageNumber;
	}

	public String getWorkPackageName() {
		return workPackageName;
	}

	public void setWorkPackageName(String workPackageName) {
		this.workPackageName = workPackageName;
	}

	public BigDecimal getOfferedCost() {
		return offeredCost;
	}

	public void setOfferedCost(BigDecimal offeredCost) {
		this.offeredCost = offeredCost;
	}
	
	public BigDecimal getCalculatedCost() {
		return calculatedCost;
	}

	public void setCalculatedCost(BigDecimal calculatedCost) {
		this.calculatedCost = calculatedCost;
	}

	public BigDecimal getTotalCost() {
		return totalCost;
	}

	public void setTotalCost(BigDecimal totalCost) {
		this.totalCost = totalCost;
	}

	public BigDecimal getEffectiveCost() {
		return effectiveCost;
	}

	public void setEffectiveCost(BigDecimal effectiveCost) {
		this.effectiveCost = effectiveCost;
	}

	public Integer getWorkDoneInPercent() {
		return workDoneInPercent;
	}

	public void setWorkDoneInPercent(Integer workDoneInPercent) {
		this.workDoneInPercent = workDoneInPercent;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}

	public List<WorkPackageUserAllocation> getWorkPackageUserAllocations() {
		return workPackageUserAllocations;
	}

	public void setWorkPackageUserAllocations(
			List<WorkPackageUserAllocation> workPackageUserAllocations) {
		this.workPackageUserAllocations = workPackageUserAllocations;
	}

}
