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

	/*//@NotEmpty
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "PROJECT_APP_USER", joinColumns = { @JoinColumn(name = "PROJECT_ID") }, inverseJoinColumns = { @JoinColumn(name = "USER_ID") })
	private Set<User> users = new HashSet<User>();

	//@NotEmpty
	@OneToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "PROJECT_WORK_PACKAGE", joinColumns = { @JoinColumn(name = "PROJECT_ID") }, inverseJoinColumns = { @JoinColumn(name = "WORK_PACKAGE_ID") })
	private Set<Workpackage> workPackages = new HashSet<Workpackage>();
*/
	
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
	
	/*public Set<User> getUsers() {
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
	}*/

	
	
	

}
