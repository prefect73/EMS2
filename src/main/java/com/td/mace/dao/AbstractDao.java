package com.td.mace.dao;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;

public abstract class AbstractDao<PK extends Serializable, T> {
	
	private final Class<T> persistentClass;
	
	@SuppressWarnings("unchecked")
	public AbstractDao(){
		this.persistentClass =(Class<T>) ((ParameterizedType) this.getClass().getGenericSuperclass()).getActualTypeArguments()[1];
	}
	
	@Autowired
	private SessionFactory sessionFactory;

	protected Session getCurrentSession(){
		return sessionFactory.getCurrentSession();
	}
	
	protected Session getNewSession(){
		return sessionFactory.openSession();
	}
	
	protected void closeSession(){
		 sessionFactory.close();
	}

	@SuppressWarnings("unchecked")
	public T getByKey(PK key) {
		return (T) getCurrentSession().get(persistentClass, key);
	}

	public void persist(T entity) {
		getCurrentSession().saveOrUpdate(entity);
	}

	public void update(T entity) {
		getCurrentSession().update(entity);
	}

	public void delete(T entity) {
		getCurrentSession().delete(entity);
	}
	
	protected Criteria createEntityCriteria(){
		return getCurrentSession().createCriteria(persistentClass);
	}

}
