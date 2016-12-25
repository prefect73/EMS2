package com.websystique.springmvc.model;

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
@Table(name = "WORK_PACKAGE")
public class WorkPackage implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	// @NotEmpty
	@Column(name = "WORK_PACKAGE_NUMBER", unique = true, nullable = true)
	private String workPackageNumber;

	@NotEmpty
	@Column(name = "WORK_PACKAGE_NAME", unique = true, nullable = false)
	private String workPackageName;

	@Column(name = "OFFERED_COST", precision = 10, scale = 2)
	private BigDecimal offeredCost;

	@Column(name = "TOTAL_COST", precision = 10, scale = 2)
	private BigDecimal totalCost;

	@ManyToOne(optional = false, fetch = FetchType.EAGER)
	@JoinColumn(name = "PROJECT_ID")
	private Project project;

	// bi-directional many-to-one association to WorkPackageAppUserAllocation
	@OneToMany(mappedBy = "workPackage")
	// , cascade= CascadeType.REMOVE
	private List<WorkPackageUserAllocation> workPackageUserAllocations = new ArrayList<WorkPackageUserAllocation>();

	// bi-directional many-to-many association to AppUser

	/*
	 * @ManyToMany(fetch = FetchType.LAZY)
	 * 
	 * @JoinTable(name = "WORK_PACKAGE_APP_USER", joinColumns = {
	 * 
	 * @JoinColumn(name = "WORK_PACKAGE_ID") }, inverseJoinColumns = {
	 * 
	 * @JoinColumn(name = "USER_ID") }) private List<User> users = new
	 * HashList<User>();
	 */
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

	public BigDecimal getTotalCost() {
		return totalCost;
	}

	public void setTotalCost(BigDecimal totalCost) {
		this.totalCost = totalCost;
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
