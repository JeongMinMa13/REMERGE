package com.kh.reMerge.user.model.service;

import com.kh.reMerge.user.model.vo.User;

public interface UserService {

	User loginMember(User u);

	int insertUser(User u);

}
