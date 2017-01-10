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

@Entity
@Table(name = "APP_USER_ATTENDANCE", uniqueConstraints = @UniqueConstraint(columnNames = {
		"USER_ID", "Year_Name" }))
public class UserAttendance implements Serializable {

	/**
  * 
  */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

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

	@Column(name = "Year_Name", precision = 10, scale = 2)
	private String yearName;

	@ManyToOne(optional = false, fetch = FetchType.EAGER)
	@JoinColumn(name = "USER_ID")
	private User user;

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
		return yearName;
	}

	public void setYearName(String yearName) {
		this.yearName = yearName;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}