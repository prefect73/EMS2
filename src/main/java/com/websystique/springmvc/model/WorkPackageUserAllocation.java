package com.websystique.springmvc.model;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.AssociationOverride;
import javax.persistence.AssociationOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * The persistent class for the work_package_app_user_allocations database
 * table.
 * 
 */
@Entity
@Table(name = "work_package_app_user_allocations")
@AssociationOverrides({
		@AssociationOverride(name = "id.workPackage", joinColumns = @JoinColumn(name = "WORK_PACKAGE_ID")),
		@AssociationOverride(name = "id.user", joinColumns = @JoinColumn(name = "USER_ID")) })
public class WorkPackageUserAllocation implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private WorkPackageUserAllocationPK id;

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

	/*
	 * // bi-directional many-to-one association to WorkPackage
	 * 
	 * @ManyToOne
	 * 
	 * @JoinColumn(name = "work_package_id") private WorkPackage workPackage;
	 * 
	 * // bi-directional many-to-one association to User
	 * 
	 * @ManyToOne
	 * 
	 * @JoinColumn(name = "user_id") private User user;
	 */

	@Transient
	public User getUser() {
		return getId().getUser();
	}

	public void setUser(User user) {
		getId().setUser(user);
	}

	@Transient
	public WorkPackage getWorkPackage() {
		return getId().getWorkPackage();
	}

	public void setWorkPackage(WorkPackage workpackage) {
		getId().setWorkPackage(workpackage);
	}

	public WorkPackageUserAllocation() {
	}

	public WorkPackageUserAllocationPK getId() {
		return this.id;
	}

	public void setId(WorkPackageUserAllocationPK id) {
		this.id = id;
	}

	public BigDecimal getMApr() {
		return this.mApr;
	}

	public void setMApr(BigDecimal mApr) {
		this.mApr = mApr;
	}

	public BigDecimal getMAug() {
		return this.mAug;
	}

	public void setMAug(BigDecimal mAug) {
		this.mAug = mAug;
	}

	public BigDecimal getMDec() {
		return this.mDec;
	}

	public void setMDec(BigDecimal mDec) {
		this.mDec = mDec;
	}

	public BigDecimal getMFeb() {
		return this.mFeb;
	}

	public void setMFeb(BigDecimal mFeb) {
		this.mFeb = mFeb;
	}

	public BigDecimal getMJan() {
		return this.mJan;
	}

	public void setMJan(BigDecimal mJan) {
		this.mJan = mJan;
	}

	public BigDecimal getMJul() {
		return this.mJul;
	}

	public void setMJul(BigDecimal mJul) {
		this.mJul = mJul;
	}

	public BigDecimal getMJun() {
		return this.mJun;
	}

	public void setMJun(BigDecimal mJun) {
		this.mJun = mJun;
	}

	public BigDecimal getMMar() {
		return this.mMar;
	}

	public void setMMar(BigDecimal mMar) {
		this.mMar = mMar;
	}

	public BigDecimal getMMay() {
		return this.mMay;
	}

	public void setMMay(BigDecimal mMay) {
		this.mMay = mMay;
	}

	public BigDecimal getMNov() {
		return this.mNov;
	}

	public void setMNov(BigDecimal mNov) {
		this.mNov = mNov;
	}

	public BigDecimal getMOct() {
		return this.mOct;
	}

	public void setMOct(BigDecimal mOct) {
		this.mOct = mOct;
	}

	public BigDecimal getMSep() {
		return this.mSep;
	}

	public void setMSep(BigDecimal mSep) {
		this.mSep = mSep;
	}

	public String getYearName() {
		return this.yearName;
	}

	public void setYearName(String yearName) {
		this.yearName = yearName;
	}

	/*
	 * public WorkPackage getWorkPackage() { return this.workPackage; }
	 * 
	 * public void setWorkPackage(WorkPackage workPackage) { this.workPackage =
	 * workPackage; }
	 * 
	 * public User getUser() { return this.user; }
	 * 
	 * public void setUser(User user) { this.user = user; }
	 */

}