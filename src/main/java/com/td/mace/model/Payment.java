package com.td.mace.model;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;

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

    @Column(name = "consultant_in_charge")
	private String consultantInCharge;

    @Column(name = "created_by")
	private String createdBy;

    @Transient
	private int finishedIn;

    @Transient
    private BigDecimal paymentPercentage;

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

    public BigDecimal getPaymentPercentage() {
        return paymentPercentage;
    }

    public void setPaymentPercentage(BigDecimal paymentPercentage) {
        this.paymentPercentage = paymentPercentage;
    }

    public String getConsultantInCharge() {
        return consultantInCharge;
    }

    public void setConsultantInCharge(String consultantInCharge) {
        this.consultantInCharge = consultantInCharge;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }
}