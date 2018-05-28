package com.td.mace.service;

import com.td.mace.model.Payment;
import com.td.mace.model.WorkPackage;

import java.util.List;

public interface PaymentService {
	
	Payment findById(int id);
	
	Payment findByPaymentName(String paymentName);
	
	void savePayment(Payment payment);
	
	void updatePayment(Payment payment);
	
	void deletePaymentByWorkPackageId(String workPackageId);
	
	void deletePaymentById(Integer id);

	List<Payment> findAllPayments();
	
	List<Payment> findAllPaymentsByWorkPackage(WorkPackage workPackage);
	
}