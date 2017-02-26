package com.td.mace.dao;

import java.util.List;

import com.td.mace.model.Payment;


public interface PaymentDao {

	Payment findById(int id);
	
	Payment findByPaymentName(String paymentName);
	
	void save(Payment Payment);
	
	void deletePaymentByWorkPackageId(String workPackageId);
	
	void deletePaymentByPaymentName(String paymentName);
	
	List<Payment> findAllPayments();
	
}

