package com.td.mace.model;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.Max;

@Entity
@Table(name = "payment")
public class Payment implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(name = "billing")
	private String billing;

	@Column(name = "time")
	private String time;

	@Column(name = "amount", precision = 10, scale = 2)
	private BigDecimal amount = new BigDecimal("0.00");

	@Column(name = "remarks")
	private String remarks;

	@Column(name = "billed")
	private String billed;

	@Max(value = 100)
	@Column(name = "finished_in")
	private int finishedIn;

	@ManyToOne(optional = false, fetch = FetchType.EAGER)
	@JoinColumn(name = "work_package_id")
	private WorkPackage workPackage;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getBilling() {
		return billing;
	}

	public void setBilling(String billing) {
		this.billing = billing;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getBilled() {
		return billed;
	}

	public void setBilled(String billed) {
		this.billed = billed;
	}

	public int getFinishedIn() {
		return finishedIn;
	}

	public void setFinishedIn(int finishedIn) {
		this.finishedIn = finishedIn;
	}

	public WorkPackage getWorkPackage() {
		return workPackage;
	}

	public void setWorkPackage(WorkPackage workPackage) {
		this.workPackage = workPackage;
	}

}