package com.td.mace.dao;

import com.td.mace.model.PasswordResetToken;

public interface PasswordResetTokenDao {
    PasswordResetToken findByToken(String token);

    void save(PasswordResetToken myToken);
}
