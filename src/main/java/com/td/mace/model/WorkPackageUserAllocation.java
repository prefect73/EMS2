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
	private BigDecimal totalPlannedDays  = new BigDecimal("0.00");

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
	
	@Column(name = "emjan", precision = 10, scale = 2)
	private BigDecimal emJan = new BigDecimal("0.00");

	@Column(name = "emfeb", precision = 10, scale = 2)
	private BigDecimal emFeb = new BigDecimal("0.00");

	@Column(name = "emmar", precision = 10, scale = 2)
	private BigDecimal emMar = new BigDecimal("0.00");

	@Column(name = "emapr", precision = 10, scale = 2)
	private BigDecimal emApr = new BigDecimal("0.00");

	@Column(name = "emmay", precision = 10, scale = 2)
	private BigDecimal emMay = new BigDecimal("0.00");

	@Column(name = "emjun", precision = 10, scale = 2)
	private BigDecimal emJun = new BigDecimal("0.00");

	@Column(name = "emjul", precision = 10, scale = 2)
	private BigDecimal emJul = new BigDecimal("0.00");

	@Column(name = "emaug", precision = 10, scale = 2)
	private BigDecimal emAug = new BigDecimal("0.00");

	@Column(name = "emsep", precision = 10, scale = 2)
	private BigDecimal emSep = new BigDecimal("0.00");

	@Column(name = "emoct", precision = 10, scale = 2)
	private BigDecimal emOct = new BigDecimal("0.00");

	@Column(name = "emnov", precision = 10, scale = 2)
	private BigDecimal emNov = new BigDecimal("0.00");

	@Column(name = "emdec", precision = 10, scale = 2)
	private BigDecimal emDec = new BigDecimal("0.00");

	
	@Column(name = "eemjan")
	private String eemJan;


	@Column(name = "eemfeb")
	private String eemFeb;


	@Column(name = "eemmar")
	private String eemMar;


	@Column(name = "eemapr")
	private String eemApr;


	@Column(name = "eemmay")
	private String eemMay;


	@Column(name = "eemjun")
	private String eemJun;


	@Column(name = "eemjul")
	private String eemJul;


	@Column(name = "eemaug")
	private String eemAug;


	@Column(name = "eemsep")
	private String eemSep;


	@Column(name = "eemoct")
	private String eemOct;


	@Column(name = "eemnov")
	private String eemNov;


	@Column(name = "eemdec")
	private String eemDec;

	@Column(name = "year_name")
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
	
	

	public String getEemJan() {
		return eemJan;
	}

	public void setEemJan(String eemJan) {
		this.eemJan = eemJan;
	}

	public String getEemFeb() {
		return eemFeb;
	}

	public void setEemFeb(String eemFeb) {
		this.eemFeb = eemFeb;
	}

	public String getEemMar() {
		return eemMar;
	}

	public void setEemMar(String eemMar) {
		this.eemMar = eemMar;
	}

	public String getEemApr() {
		return eemApr;
	}

	public void setEemApr(String eemApr) {
		this.eemApr = eemApr;
	}

	public String getEemMay() {
		return eemMay;
	}

	public void setEemMay(String eemMay) {
		this.eemMay = eemMay;
	}

	public String getEemJun() {
		return eemJun;
	}

	public void setEemJun(String eemJun) {
		this.eemJun = eemJun;
	}

	public String getEemJul() {
		return eemJul;
	}

	public void setEemJul(String eemJul) {
		this.eemJul = eemJul;
	}

	public String getEemAug() {
		return eemAug;
	}

	public void setEemAug(String eemAug) {
		this.eemAug = eemAug;
	}

	public String getEemSep() {
		return eemSep;
	}

	public void setEemSep(String eemSep) {
		this.eemSep = eemSep;
	}

	public String getEemOct() {
		return eemOct;
	}

	public void setEemOct(String eemOct) {
		this.eemOct = eemOct;
	}

	public String getEemNov() {
		return eemNov;
	}

	public void setEemNov(String eemNov) {
		this.eemNov = eemNov;
	}

	public String getEemDec() {
		return eemDec;
	}

	public void setEemDec(String eemDec) {
		this.eemDec = eemDec;
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

	@Override
	public String toString() {
		return "WorkPackageUserAllocation [id=" + id + ", totalPlannedDays="
				+ totalPlannedDays + ", mJan=" + mJan + ", mFeb=" + mFeb
				+ ", mMar=" + mMar + ", mApr=" + mApr + ", mMay=" + mMay
				+ ", mJun=" + mJun + ", mJul=" + mJul + ", mAug=" + mAug
				+ ", mSep=" + mSep + ", mOct=" + mOct + ", mNov=" + mNov
				+ ", mDec=" + mDec + ", emJan=" + emJan + ", emFeb=" + emFeb
				+ ", emMar=" + emMar + ", emApr=" + emApr + ", emMay=" + emMay
				+ ", emJun=" + emJun + ", emJul=" + emJul + ", emAug=" + emAug
				+ ", emSep=" + emSep + ", emOct=" + emOct + ", emNov=" + emNov
				+ ", emDec=" + emDec + ", eemJan=" + eemJan + ", eemFeb="
				+ eemFeb + ", eemMar=" + eemMar + ", eemApr=" + eemApr
				+ ", eemMay=" + eemMay + ", eemJun=" + eemJun + ", eemJul="
				+ eemJul + ", eemAug=" + eemAug + ", eemSep=" + eemSep
				+ ", eemOct=" + eemOct + ", eemNov=" + eemNov + ", eemDec="
				+ eemDec + ", yearName=" + yearName + ", workPackage="
				+ workPackage + ", user=" + user + "]";
	}
	
	

}