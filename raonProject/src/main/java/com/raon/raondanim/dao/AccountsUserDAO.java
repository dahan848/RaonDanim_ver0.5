package com.raon.raondanim.dao;

import com.raon.raondanim.model.User;

public interface AccountsUserDAO {
	public int joinUser (User user);
	public User selectByUserId (String UserId);
	public int email_verify (User user);
}
