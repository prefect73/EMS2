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
import javax.persistence.Table;

import org.hibernate.validator.constraints.NotEmpty;

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
	@Column(name = "SSO_ID", unique = true, nullable = false)
	private String ssoId;

	@NotEmpty
	@Column(name = "PASSWORD", nullable = false)
	private String password;

	@NotEmpty
	@Column(name = "FIRST_NAME", nullable = false)
	private String firstName;

	@NotEmpty
	@Column(name = "LAST_NAME", nullable = false)
	private String lastName;

	@NotEmpty
	@Column(name = "EMAIL", nullable = false)
	private String email;

	@Column(name = "PER_HOUR_COST", precision = 10, scale = 2)
	// @DecimalMax("12.00")
	private BigDecimal perHourCost;

	@Column(name = "PER_DAY_HOURS", precision = 10, scale = 2)
	// @DecimalMax("30.00")
	private BigDecimal perDayHours;
	
	@Column(name = "mJan", precision = 10, scale = 2)
	 private BigDecimal mJan;

	 @Column(name = "mFeb", precision = 10, scale = 2)
	 private BigDecimal mFeb;

	 @Column(name = "mMar", precision = 10, scale = 2)
	 private BigDecimal mMar;

	 @Column(name = "mApr", precision = 10, scale = 2)
	 private BigDecimal mApr;

	 @Column(name = "mMay", precision = 10, scale = 2)
	 private BigDecimal mMay;

	 @Column(name = "mJun", precision = 10, scale = 2)
	 private BigDecimal mJun;

	 @Column(name = "mJul", precision = 10, scale = 2)
	 private BigDecimal mJul;

	 @Column(name = "mAug", precision = 10, scale = 2)
	 private BigDecimal mAug;

	 @Column(name = "mSep", precision = 10, scale = 2)
	 private BigDecimal mSep;

	 @Column(name = "mOct", precision = 10, scale = 2)
	 private BigDecimal mOct;

	 @Column(name = "mNov", precision = 10, scale = 2)
	 private BigDecimal mNov;

	 @Column(name = "mDec", precision = 10, scale = 2)
	 private BigDecimal mDec;

	 @Column(name = "Year_Name", precision = 10, scale = 2)
	 private String yearName;

	@NotEmpty
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "APP_USER_USER_PROFILE", joinColumns = { @JoinColumn(name = "USER_ID") }, inverseJoinColumns = { @JoinColumn(name = "USER_PROFILE_ID") })
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

	public BigDecimal getPerHourCost() {
		return perHourCost;
	}

	public void setPerHourCost(BigDecimal perHourCost) {
		this.perHourCost = perHourCost;
	}

	public BigDecimal getPerDayHours() {
		return perDayHours;
	}

	public void setPerDayHours(BigDecimal perMonthCost) {
		this.perDayHours = perMonthCost;
	}
	

	public BigDecimal getmJan() {
		return mJan;
	}

	public void setmJan(BigDecimal mJan) {
		this.mJan = mJan;
	}

	public BigDecimal getmFeb() {
		return mFeb;
	}

	public void setmFeb(BigDecimal mFeb) {
		this.mFeb = mFeb;
	}

	public BigDecimal getmMar() {
		return mMar;
	}

	public void setmMar(BigDecimal mMar) {
		this.mMar = mMar;
	}

	public BigDecimal getmApr() {
		return mApr;
	}

	public void setmApr(BigDecimal mApr) {
		this.mApr = mApr;
	}

	public BigDecimal getmMay() {
		return mMay;
	}

	public void setmMay(BigDecimal mMay) {
		this.mMay = mMay;
	}

	public BigDecimal getmJun() {
		return mJun;
	}

	public void setmJun(BigDecimal mJun) {
		this.mJun = mJun;
	}

	public BigDecimal getmJul() {
		return mJul;
	}

	public void setmJul(BigDecimal mJul) {
		this.mJul = mJul;
	}

	public BigDecimal getmAug() {
		return mAug;
	}

	public void setmAug(BigDecimal mAug) {
		this.mAug = mAug;
	}

	public BigDecimal getmSep() {
		return mSep;
	}

	public void setmSep(BigDecimal mSep) {
		this.mSep = mSep;
	}

	public BigDecimal getmOct() {
		return mOct;
	}

	public void setmOct(BigDecimal mOct) {
		this.mOct = mOct;
	}

	public BigDecimal getmNov() {
		return mNov;
	}

	public void setmNov(BigDecimal mNov) {
		this.mNov = mNov;
	}

	public BigDecimal getmDec() {
		return mDec;
	}

	public void setmDec(BigDecimal mDec) {
		this.mDec = mDec;
	}

	public String getYearName() {
		return yearName;
	}

	public void setYearName(String yearName) {
		this.yearName = yearName;
	}

	public Set<UserProfile> getUserProfiles() {
		return userProfiles;
	}

	public void setUserProfiles(Set<UserProfile> userProfiles) {
		this.userProfiles = userProfiles;
	}

}
