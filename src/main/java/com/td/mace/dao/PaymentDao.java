package com.td.mace.dao;

import java.util.List;

import com.td.mace.model.Payment;
import com.td.mace.model.WorkPackage;


public interface PaymentDao {

	Payment findById(int id);
	
	Payment findByPaymentName(String paymentName);
	
	void save(Payment Payment);
	
	void deletePaymentByWorkPackageId(String workPackageId);
	
	void deletePaymentById(Integer id);
	
	List<Payment> findAllPayments();
	
	List<Payment> findAllPaymentsByWorkPackage(WorkPackage workPackage);
	
}

