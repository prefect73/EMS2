package com.websystique.springmvc.model;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * The persistent class for the work_package_app_user_allocations database
 * table.
 * 
 */
@Entity
@Table(name = "work_package_app_user_allocations")
public class WorkPackageUserAllocation implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

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

	// bi-directional many-to-one association to WorkPackage

	@ManyToOne(cascade = CascadeType.REMOVE, fetch = FetchType.EAGER)
	@JoinColumn(name = "work_package_id")
	private WorkPackage workPackage;

	// bi-directional many-to-one association to User

	@ManyToOne(cascade = CascadeType.REMOVE, fetch = FetchType.EAGER)
	@JoinColumn(name = "user_id")
	private User user;

	/*
	 * @Transient private int workPackageId;
	 * 
	 * 
	 * public int getWorkPackageId() { return workPackageId; }
	 * 
	 * 
	 * 
	 * public void setWorkPackageId(int workPackageId) { this.workPackageId =
	 * workPackageId; }
	 */

	public WorkPackageUserAllocation() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
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
		return this.yearName;
	}

	public void setYearName(String yearName) {
		this.yearName = yearName;
	}

	@JsonIgnore
	public WorkPackage getWorkPackage() {
		return this.workPackage;
	}

	public void setWorkPackage(WorkPackage workPackage) {
		this.workPackage = workPackage;
	}

	@JsonIgnore
	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}