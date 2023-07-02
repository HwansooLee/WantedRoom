package com.human.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.human.VO.LikesVO;

@Repository
public class LikesImpl implements IF_LikesDAO{
	
	private final static String mapperQuery = "com.human.dao.IF_LikesDAO";
	
	@Inject
	private SqlSession sqlSession;

	@Override
	public void insert(LikesVO lvo) throws Exception {
		sqlSession.insert(mapperQuery+".insert",lvo);
	}

}
