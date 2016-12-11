package com.websystique.springmvc.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name = "PROJECT")
public class Project implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@NotEmpty
	@Column(name = "PROJECT_NUMBER", unique = true, nullable = false)
	private String projectNumber;

	
	@NotEmpty
	@Column(name = "PROJECT_NAME", unique = true, nullable = false)
	private String projectName;

	@NotEmpty
	@Column(name = "CUSTOMER_NAME", unique = true, nullable = false)
	private String customerName;


	@Column(name = "OFFERED_COST", precision = 10, scale = 2)
	private BigDecimal offeredCost;

	@Column(name = "TOTAL_COST", precision = 10, scale = 2)
	private BigDecimal totalCost;

	@NotEmpty
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "PROJECT_APP_USER", joinColumns = { @JoinColumn(name = "PROJECT_ID") }, inverseJoinColumns = { @JoinColumn(name = "USER_ID") })
	private Set<User> users = new HashSet<User>();

	@NotEmpty
	@OneToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "PROJECT_WORK_PACKAGE", joinColumns = { @JoinColumn(name = "PROJECT_ID") }, inverseJoinColumns = { @JoinColumn(name = "WORK_PACKAGE_ID") })
	private Set<Workpackage> workPackages = new HashSet<Workpackage>();

	
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
	
	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
		this.users = users;
	}

	public Set<Workpackage> getWorkPackages() {
		return workPackages;
	}

	public void setWorkPackages(Set<Workpackage> workPackages) {
		this.workPackages = workPackages;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((customerName == null) ? 0 : customerName.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((offeredCost == null) ? 0 : offeredCost.hashCode());
		result = prime * result
				+ ((projectName == null) ? 0 : projectName.hashCode());
		result = prime * result
				+ ((projectNumber == null) ? 0 : projectNumber.hashCode());
		result = prime * result
				+ ((totalCost == null) ? 0 : totalCost.hashCode());
		result = prime * result + ((users == null) ? 0 : users.hashCode());
		result = prime * result
				+ ((workPackages == null) ? 0 : workPackages.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Project other = (Project) obj;
		if (customerName == null) {
			if (other.customerName != null)
				return false;
		} else if (!customerName.equals(other.customerName))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (offeredCost == null) {
			if (other.offeredCost != null)
				return false;
		} else if (!offeredCost.equals(other.offeredCost))
			return false;
		if (projectName == null) {
			if (other.projectName != null)
				return false;
		} else if (!projectName.equals(other.projectName))
			return false;
		if (projectNumber == null) {
			if (other.projectNumber != null)
				return false;
		} else if (!projectNumber.equals(other.projectNumber))
			return false;
		if (totalCost == null) {
			if (other.totalCost != null)
				return false;
		} else if (!totalCost.equals(other.totalCost))
			return false;
		if (users == null) {
			if (other.users != null)
				return false;
		} else if (!users.equals(other.users))
			return false;
		if (workPackages == null) {
			if (other.workPackages != null)
				return false;
		} else if (!workPackages.equals(other.workPackages))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Project [id=" + id + ", projectNumber=" + projectNumber
				+ ", projectName=" + projectName + ", customerName="
				+ customerName + ", offeredCost=" + offeredCost
				+ ", totalCost=" + totalCost + ", users=" + users
				+ ", workPackages=" + workPackages + "]";
	}
	
	

}
