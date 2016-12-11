package com.websystique.springmvc.model;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name = "WORK_PACKAGE")
public class Workpackage implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@NotEmpty
	@Column(name = "WORK_PACKAGE_NUMBER", unique = true, nullable = false)
	private String workpackageNumber;

	@NotEmpty
	@Column(name = "WORK_PACKAGE_NAME", unique = true, nullable = false)
	private String workpackageName;

	@Column(name = "OFFERED_COST", precision = 10, scale = 2)
	private BigDecimal offeredCost;

	@Column(name = "TOTAL_COST", precision = 10, scale = 2)
	private BigDecimal totalCost;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getWorkpackageNumber() {
		return workpackageNumber;
	}

	public void setWorkpackageNumber(String workpackageNumber) {
		this.workpackageNumber = workpackageNumber;
	}

	public String getWorkpackageName() {
		return workpackageName;
	}

	public void setWorkpackageName(String workpackageName) {
		this.workpackageName = workpackageName;
	}

	public BigDecimal getOfferedCost() {
		return offeredCost;
	}

	public void setOfferedCost(BigDecimal offeredCost) {
		this.offeredCost = offeredCost;
	}

	public BigDecimal getTotalCost() {
		return totalCost;
	}

	public void setTotalCost(BigDecimal totalCost) {
		this.totalCost = totalCost;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((offeredCost == null) ? 0 : offeredCost.hashCode());
		result = prime * result
				+ ((workpackageName == null) ? 0 : workpackageName.hashCode());
		result = prime * result
				+ ((workpackageNumber == null) ? 0 : workpackageNumber.hashCode());
		result = prime * result
				+ ((totalCost == null) ? 0 : totalCost.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Workpackage other = (Workpackage) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (offeredCost == null) {
			if (other.offeredCost != null)
				return false;
		} else if (!offeredCost.equals(other.offeredCost))
			return false;
		if (workpackageName == null) {
			if (other.workpackageName != null)
				return false;
		} else if (!workpackageName.equals(other.workpackageName))
			return false;
		if (workpackageNumber == null) {
			if (other.workpackageNumber != null)
				return false;
		} else if (!workpackageNumber.equals(other.workpackageNumber))
			return false;
		if (totalCost == null) {
			if (other.totalCost != null)
				return false;
		} else if (!totalCost.equals(other.totalCost))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Workpackage [id=" + id + ", workpackageNumber=" + workpackageNumber
				+ ", workpackageName=" + workpackageName + ", offeredCost="
				+ offeredCost + ", totalCost=" + totalCost + "]";
	}

}
