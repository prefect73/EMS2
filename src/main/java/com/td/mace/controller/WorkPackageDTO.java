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

    private String status;


    public WorkPackageDTO(WorkPackage workPackage) {
        this.id = workPackage.getId();
        this.workPackageName = workPackage.getWorkPackageName();
        this.offeredCost = workPackage.getOfferedCost();
        this.calculatedCost = workPackage.getCalculatedCost();
        this.totalCost = workPackage.getTotalCost();
        this.effectiveCost = workPackage.getEffectiveCost();
        this.workDoneInPercent = workPackage.getWorkDoneInPercent();
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "WorkPackageDTO{" +
                "id=" + id +
                ", workPackageName='" + workPackageName + '\'' +
                ", offeredCost=" + offeredCost +
                ", calculatedCost=" + calculatedCost +
                ", totalCost=" + totalCost +
                ", effectiveCost=" + effectiveCost +
                ", workDoneInPercent=" + workDoneInPercent +
                ", status='" + status + '\'' +
                '}';
    }
}
