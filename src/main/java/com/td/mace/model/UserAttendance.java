package com.td.mace.model;

import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import javax.validation.constraints.DecimalMax;
import java.io.Serializable;
import java.math.BigDecimal;

@Entity
@Table(name = "app_user_attendance", uniqueConstraints = @UniqueConstraint(columnNames = {
		"user_id", "year_name" }))
public class UserAttendance implements Serializable {

	/**
  * 
  */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@DecimalMax(value = "31.00")
	@Column(name = "mjan", precision = 10, scale = 2)
	private BigDecimal mJan = new BigDecimal("0.00");

	@DecimalMax(value = "29.00")
	@Column(name = "mfeb", precision = 10, scale = 2)
	private BigDecimal mFeb = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "mmar", precision = 10, scale = 2)
	private BigDecimal mMar = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "mapr", precision = 10, scale = 2)
	private BigDecimal mApr = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "mmay", precision = 10, scale = 2)
	private BigDecimal mMay = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "mjun", precision = 10, scale = 2)
	private BigDecimal mJun = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "mjul", precision = 10, scale = 2)
	private BigDecimal mJul = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "maug", precision = 10, scale = 2)
	private BigDecimal mAug = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "msep", precision = 10, scale = 2)
	private BigDecimal mSep = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "moct", precision = 10, scale = 2)
	private BigDecimal mOct = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "mnov", precision = 10, scale = 2)
	private BigDecimal mNov = new BigDecimal("0.00");

	@DecimalMax(value = "31.00")
	@Column(name = "mdec", precision = 10, scale = 2)
	private BigDecimal mDec = new BigDecimal("0.00");

	@Column(name = "year_name", precision = 10, scale = 2)
	private String yearName;

	@ManyToOne(optional = false, fetch = FetchType.EAGER, cascade = CascadeType.REMOVE)
	@JoinColumn(name = "user_id")
	@OnDelete(action = OnDeleteAction.CASCADE)
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