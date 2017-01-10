package com.td.mace.model;

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
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.DecimalMax;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * The persistent class for the work_package_app_user_allocations database
 * table.
 * 
 */
@Entity
@Table(name = "work_package_app_user_allocations", uniqueConstraints = @UniqueConstraint(columnNames = {
		"user_id","work_package_id", "Year_Name" }))
public class WorkPackageUserAllocation implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@Column(name = "total_planned_days", precision = 10, scale = 2)
	private BigDecimal totalPlannedDays  = new BigDecimal("0.00");;

	@DecimalMax(value = "31.00")
	@Column(name = "mJan", precision = 10, scale = 2)
	private BigDecimal mJan = new BigDecimal("0.00");

	@DecimalMax(value = "29.00")
	@Column(name = "mFeb", precision = 10, scale = 2)
	private BigDecimal mFeb = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "mMar", precision = 10, scale = 2)
	private BigDecimal mMar = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "mApr", precision = 10, scale = 2)
	private BigDecimal mApr = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "mMay", precision = 10, scale = 2)
	private BigDecimal mMay = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "mJun", precision = 10, scale = 2)
	private BigDecimal mJun = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "mJul", precision = 10, scale = 2)
	private BigDecimal mJul = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "mAug", precision = 10, scale = 2)
	private BigDecimal mAug = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "mSep", precision = 10, scale = 2)
	private BigDecimal mSep = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "mOct", precision = 10, scale = 2)
	private BigDecimal mOct = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "mNov", precision = 10, scale = 2)
	private BigDecimal mNov = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "mDec", precision = 10, scale = 2)
	private BigDecimal mDec = new BigDecimal("0.00");
	
	@DecimalMax(value = "31.00")
	@Column(name = "emJan", precision = 10, scale = 2)
	private BigDecimal emJan = new BigDecimal("0.00");

	@DecimalMax(value = "29.00")
	@Column(name = "emFeb", precision = 10, scale = 2)
	private BigDecimal emFeb = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "emMar", precision = 10, scale = 2)
	private BigDecimal emMar = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "emApr", precision = 10, scale = 2)
	private BigDecimal emApr = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "emMay", precision = 10, scale = 2)
	private BigDecimal emMay = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "emJun", precision = 10, scale = 2)
	private BigDecimal emJun = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "emJul", precision = 10, scale = 2)
	private BigDecimal emJul = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "emAug", precision = 10, scale = 2)
	private BigDecimal emAug = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "emSep", precision = 10, scale = 2)
	private BigDecimal emSep = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "emOct", precision = 10, scale = 2)
	private BigDecimal emOct = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "emNov", precision = 10, scale = 2)
	private BigDecimal emNov = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "emDec", precision = 10, scale = 2)
	private BigDecimal emDec = new BigDecimal("0.00");
	

	@Column(name = "Year_Name")
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

	public BigDecimal getTotalPlannedDays() {
		return totalPlannedDays;
	}

	public void setTotalPlannedDays(BigDecimal totalPlannedDays) {
		this.totalPlannedDays = totalPlannedDays;
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

	public BigDecimal getEmJan() {
		return emJan;
	}

	public void setEmJan(BigDecimal emJan) {
		this.emJan = emJan;
	}

	public BigDecimal getEmFeb() {
		return emFeb;
	}

	public void setEmFeb(BigDecimal emFeb) {
		this.emFeb = emFeb;
	}

	public BigDecimal getEmMar() {
		return emMar;
	}

	public void setEmMar(BigDecimal emMar) {
		this.emMar = emMar;
	}

	public BigDecimal getEmApr() {
		return emApr;
	}

	public void setEmApr(BigDecimal emApr) {
		this.emApr = emApr;
	}

	public BigDecimal getEmMay() {
		return emMay;
	}

	public void setEmMay(BigDecimal emMay) {
		this.emMay = emMay;
	}

	public BigDecimal getEmJun() {
		return emJun;
	}

	public void setEmJun(BigDecimal emJun) {
		this.emJun = emJun;
	}

	public BigDecimal getEmJul() {
		return emJul;
	}

	public void setEmJul(BigDecimal emJul) {
		this.emJul = emJul;
	}

	public BigDecimal getEmAug() {
		return emAug;
	}

	public void setEmAug(BigDecimal emAug) {
		this.emAug = emAug;
	}

	public BigDecimal getEmSep() {
		return emSep;
	}

	public void setEmSep(BigDecimal emSep) {
		this.emSep = emSep;
	}

	public BigDecimal getEmOct() {
		return emOct;
	}

	public void setEmOct(BigDecimal emOct) {
		this.emOct = emOct;
	}

	public BigDecimal getEmNov() {
		return emNov;
	}

	public void setEmNov(BigDecimal emNov) {
		this.emNov = emNov;
	}

	public BigDecimal getEmDec() {
		return emDec;
	}

	public void setEmDec(BigDecimal emDec) {
		this.emDec = emDec;
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