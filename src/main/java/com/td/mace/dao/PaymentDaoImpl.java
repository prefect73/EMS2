package com.td.mace.dao;

import com.td.mace.model.Payment;
import com.td.mace.model.WorkPackage;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

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

	public void deletePaymentById(Integer id) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("id", id));
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

	@SuppressWarnings("unchecked")
	@Override
	public List<Payment> findAllPayments() {
		Criteria criteria = createEntityCriteria().addOrder(Order.asc("id"));
		criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);// To avoid duplicates.
		List<Payment> payments = (List<Payment>) criteria.list();
		return payments;
	}

	@SuppressWarnings("unchecked")
	public List<Payment> findAllPaymentsByWorkPackage(WorkPackage workPackage) {
		Query query = getCurrentSession()
				.createSQLQuery(
						"select * from payment where work_package_id = :workPackageId")
				.addEntity(Payment.class);
		query.setParameter("workPackageId", workPackage.getId());
		List<Payment> payments = query.list();
		return payments;
	}

}
