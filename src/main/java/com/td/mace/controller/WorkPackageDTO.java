package com.td.mace.controller;

import com.td.mace.model.WorkPackage;

import java.math.BigDecimal;

public class WorkPackageDTO {

    private Integer id;

    private String workPackageName;

    private BigDecimal offeredCost = new BigDecimal("0.00");

    private BigDecimal calculatedCost = new BigDecimal("0.00");

    private BigDecimal totalCost = new BigDecimal("0.00");

    private BigDecimal effectiveCost = new BigDecimal("0.00");

    private Integer workDoneInPercent;

    private BigDecimal paymentPercentage;

    private String status;


    public WorkPackageDTO(WorkPackage workPackage) {
        this.id = workPackage.getId();
        this.workPackageName = workPackage.getWorkPackageName();
        this.offeredCost = workPackage.getOfferedCost();
        this.calculatedCost = workPackage.getCalculatedCost();
        this.totalCost = workPackage.getTotalCost();
        this.effectiveCost = workPackage.getEffectiveCost();
        this.workDoneInPercent = workPackage.getWorkDoneInPercent();
        this.paymentPercentage = PaymentUtils.calculatePaymentPercentage(workPackage);
        this.status = workPackage.getStatus();

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getWorkPackageName() {
        return workPackageName;
    }

    public void setWorkPackageName(String workPackageName) {
        this.workPackageName = workPackageName;
    }

    public BigDecimal getOfferedCost() {
        return offeredCost;
    }

    public void setOfferedCost(BigDecimal offeredCost) {
        this.offeredCost = offeredCost;
    }

    public BigDecimal getCalculatedCost() {
        return calculatedCost;
    }

    public void setCalculatedCost(BigDecimal calculatedCost) {
        this.calculatedCost = calculatedCost;
    }

    public BigDecimal getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(BigDecimal totalCost) {
        this.totalCost = totalCost;
    }

    public BigDecimal getEffectiveCost() {
        return effectiveCost;
    }

    public void setEffectiveCost(BigDecimal effectiveCost) {
        this.effectiveCost = effectiveCost;
    }

    public Integer getWorkDoneInPercent() {
        return workDoneInPercent;
    }

    public void setWorkDoneInPercent(Integer workDoneInPercent) {
        this.workDoneInPercent = workDoneInPercent;
    }

    public BigDecimal getPaymentPercentage() {
        return paymentPercentage;
    }

    public void setPaymentPercentage(BigDecimal paymentPercentage) {
        this.paymentPercentage = paymentPercentage;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("WorkPackageDTO{");
        sb.append("id=").append(id);
        sb.append(", workPackageName='").append(workPackageName).append('\'');
        sb.append(", offeredCost=").append(offeredCost);
        sb.append(", calculatedCost=").append(calculatedCost);
        sb.append(", totalCost=").append(totalCost);
        sb.append(", effectiveCost=").append(effectiveCost);
        sb.append(", workDoneInPercent=").append(workDoneInPercent);
        sb.append(", paymentPercentage=").append(paymentPercentage);
        sb.append(", status='").append(status).append('\'');
        sb.append('}');
        return sb.toString();
    }
}
