package com.td.mace.service;

import java.util.List;

import com.td.mace.model.Payment;

public interface PaymentService {
	
	Payment findById(int id);
	
	Payment findByPaymentName(String paymentName);
	
	void savePayment(Payment payment);
	
	void updatePayment(Payment payment);
	
	void deletePaymentByWorkPackageId(String workPackageId);
	
	void deletePaymentByPaymentName(String paymentName);

	List<Payment> findAllPayments();
	
}