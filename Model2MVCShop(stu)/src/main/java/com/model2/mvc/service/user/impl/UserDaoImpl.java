package com.model2.mvc.service.user.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserDao;

@Repository("userDaoImpl")
public class UserDaoImpl implements UserDao {
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public UserDaoImpl() {
	}

	///Method
	//==>회원정보 :: INSERT(회원가입)
	public void insertUser(User user) throws Exception {
		sqlSession.insert("UserMapper.addUser", user);
	}

	//==>회원정보 :: SELECT(회원정보 검색)
	public User findUser(String userId) throws Exception {
		return sqlSession.selectOne("UserMapper.getUser", userId);
	}
	
	//==>회원정보 :: SELECT(회원정보 검색)
	public List<User> getUserList(Search search) throws Exception {
		return sqlSession.selectList("UserMapper.getUserList", search);
	}

	//==>회원정보 :: UPDATE(회원정보 변경)
	public int updateUser(User user) throws Exception {
		return sqlSession.update("UserMapper.updateUser", user);
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("UserMapper.getTotalCount", search);
	}

	@Override
	public List<User> getAllUserList() throws Exception {
		return sqlSession.selectList("UserMapper.getAllUserList");
	}

}
