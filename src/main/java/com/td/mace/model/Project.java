package com.td.mace.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.*;

import org.hibernate.validator.constraints.NotEmpty;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "project")
public class Project implements Serializable {

	/**
  * 
  */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	// @NotEmpty
	@Column(name = "project_number", unique = true, nullable = true)
	private String projectNumber;

	@NotEmpty
	@Column(name = "project_name", unique = true, nullable = false)
	private String projectName;

	@NotEmpty
	@Column(name = "customer_name", nullable = false)
	private String customerName;

	@Column(name = "offered_cost", precision = 10, scale = 2)
	private BigDecimal offeredCost = new BigDecimal("0.00");

	@Column(name = "total_cost", precision = 10, scale = 2)
	private BigDecimal totalCost =  new BigDecimal("0.00");
	
	@Column(name = "effective_cost", precision = 10, scale = 2)
	private BigDecimal effectiveCost=  new BigDecimal("0.00");

	@Column(name = "year_name", precision = 10, scale = 2)
	private String yearName;
	
	
	@ManyToMany(fetch = FetchType.EAGER)
	@JoinTable(name = "project_app_user", joinColumns = { @JoinColumn(name = "project_id") }, inverseJoinColumns = { @JoinColumn(name = "user_id") })
	private Set<User> users = new HashSet<User>();
	
	@OneToMany(mappedBy = "project")
	private List<WorkPackage> workPackages = new ArrayList<WorkPackage>();

	@Column(name = "work_done_in_percent", nullable = false)
	private Integer workDoneInPercent;

	@Column(name = "status")
	private String status;

	@Transient
    private Boolean isWorkPackagesFinished;

	@Transient
	private Boolean isAllocatedToLoggedUser;

    public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getProjectNumber() {
		return projectNumber;
	}

	public void setProjectNumber(String projectNumber) {
		this.projectNumber = projectNumber;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
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

	public BigDecimal getEffectiveCost() {
		return effectiveCost;
	}

	public void setEffectiveCost(BigDecimal effectiveCost) {
		this.effectiveCost = effectiveCost;
	}

	public String getYearName() {
		return yearName;
	}

	public void setYearName(String yearName) {
		this.yearName = yearName;
	}

    public Integer getWorkDoneInPercent() {
        return workDoneInPercent;
    }

    public void setWorkDoneInPercent(Integer workDoneInPercent) {
        this.workDoneInPercent = workDoneInPercent;
    }

    @JsonIgnore
	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
		this.users = users;
	}

	public List<WorkPackage> getWorkPackages() {
		return workPackages;
	}

	public void setWorkPackages(List<WorkPackage> workPackages) {
		this.workPackages = workPackages;
	}

    public Boolean getIsAllocatedToLoggedUser() {
        return isAllocatedToLoggedUser;
    }

    public void setIsAllocatedToLoggedUser(Boolean allocatedToLoggedUser) {
        isAllocatedToLoggedUser = allocatedToLoggedUser;
    }

    public void setIsWorkPackagesFinished(Boolean isWorkPackagesFinished) {
        this.isWorkPackagesFinished = isWorkPackagesFinished;
    }

    public Boolean getIsWorkPackagesFinished() {
        return isWorkPackagesFinished;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}