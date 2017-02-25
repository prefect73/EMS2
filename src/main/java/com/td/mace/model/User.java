package com.td.mace.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
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

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "APP_USER")
public class User implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@NotEmpty
	@Column(name = "sso_id", unique = true, nullable = false)
	private String ssoId;

	@NotEmpty
	@Column(name = "password", nullable = false)
	private String password;

	@NotEmpty
	@Column(name = "first_name", nullable = false)
	private String firstName;

	@NotEmpty
	@Column(name = "last_name", nullable = false)
	private String lastName;

	@NotEmpty
	@Column(name = "email", nullable = false)
	private String email;

	@Column(name = "per_day_cost", precision = 10, scale = 2)
	// @DecimalMax("12.00")
	private BigDecimal perDayCost;

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "user", cascade = CascadeType.REMOVE)
	private Set<WorkPackageUserAllocation> workPackageUserAllocations = new HashSet<WorkPackageUserAllocation>();

	@NotEmpty
	@ManyToMany(fetch = FetchType.EAGER)
	@JoinTable(name = "app_user_user_profile", joinColumns = { @JoinColumn(name = "user_id") }, inverseJoinColumns = { @JoinColumn(name = "user_profile_id") })
	private Set<UserProfile> userProfiles = new HashSet<UserProfile>();

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getSsoId() {
		return ssoId;
	}

	public void setSsoId(String ssoId) {
		this.ssoId = ssoId;
	}

	@JsonIgnore
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public BigDecimal getPerDayCost() {
		return perDayCost;
	}

	public void setPerDayCost(BigDecimal perDayCost) {
		this.perDayCost = perDayCost;
	}

	public Set<WorkPackageUserAllocation> getWorkPackageUserAllocations() {
		return workPackageUserAllocations;
	}

	public void setWorkPackageUserAllocations(
			Set<WorkPackageUserAllocation> workPackageUserAllocations) {
		this.workPackageUserAllocations = workPackageUserAllocations;
	}

	@JsonIgnore
	public Set<UserProfile> getUserProfiles() {
		return userProfiles;
	}

	public void setUserProfiles(Set<UserProfile> userProfiles) {
		this.userProfiles = userProfiles;
	}

}
