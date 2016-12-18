package com.websystique.springmvc.model;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The primary key class for the work_package_app_user_allocations database table.
 * 
 */
@Embeddable
public class WorkPackageUserAllocationPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	private User user;
    private WorkPackage workPackage;

	@ManyToOne
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@ManyToOne
	public WorkPackage getWorkPackage() {
		return workPackage;
	}

	public void setWorkPackage(WorkPackage workPackage) {
		this.workPackage = workPackage;
	}

	public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        WorkPackageUserAllocationPK that = (WorkPackageUserAllocationPK) o;

        if (user != null ? !user.equals(that.user) : that.user != null) return false;
        if (workPackage != null ? !workPackage.equals(that.workPackage) : that.workPackage != null)
            return false;

        return true;
    }

    public int hashCode() {
        int result;
        result = (user != null ? user.hashCode() : 0);
        result = 31 * result + (workPackage != null ? workPackage.hashCode() : 0);
        return result;
    }
}