package com.td.mace.dao;

import com.td.mace.model.PasswordResetToken;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

@Repository("passwordResetTokenDao")
public class PasswordResetTokenDaoImpl extends AbstractDao<Integer, PasswordResetToken>
        implements PasswordResetTokenDao {

    @Override
    public PasswordResetToken findByToken(String token) {
        Criteria criteria = createEntityCriteria();
        criteria.add(Restrictions.eq("token", token));
        return (PasswordResetToken) criteria.uniqueResult();
    }

    @Override
    public void save(PasswordResetToken myToken) {
        persist(myToken);
    }
}
