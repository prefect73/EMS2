package com.td.mace.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.td.mace.model.Payment;
import com.td.mace.model.Project;

@Repository("paymentDao")
public class PaymentDaoImpl extends AbstractDao<Integer, Payment> implements
		PaymentDao {

	static final Logger logger = LoggerFactory.getLogger(PaymentDaoImpl.class);
	
	@Autowired
	private UserDao userDao;

	public void save(Payment payment) {
		persist(payment);
	}

	public void deletePaymentByWorkPackageId(String workPackageId) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("workPackageId", workPackageId));
		Payment payment = (Payment) crit.uniqueResult();
		delete(payment);
	}
	
	public void deletePaymentByPaymentName(String paymentName) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("paymentName", paymentName));
		Payment payment = (Payment) crit.uniqueResult();
		delete(payment);
	}

	@Override
	public Payment findById(int id) {
		Payment payment = getByKey(id);

		if (payment != null) {
			Hibernate.initialize(payment.getWorkPackage());
		}

		return payment;
	}
	
	@Override
	public Payment findByPaymentName(String paymentName) {
		logger.info("PaymentName : {}", paymentName);
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("paymentName", paymentName));
		Payment payment = (Payment) crit.uniqueResult();

		if (payment != null) {
			Hibernate.initialize(payment.getWorkPackage());
		}

		return payment;
	}

	@Override
	public List<Payment> findAllPayments() {
		Criteria criteria = createEntityCriteria().addOrder(
				Order.asc("paymentName"));
		criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);// To avoid
																		// duplicates.
		List<Payment> payments = (List<Payment>) criteria.list();

		// No need to fetch projectProfiles since we are not showing them on
		// list page. Let them lazy load.
		// Uncomment below lines for eagerly fetching of projectProfiles if you
		// want.
		/*
		 * for(Project project : projects){
		 * Hibernate.initialize(project.getProjectProfiles()); }
		 */
		return payments;
	}

}
