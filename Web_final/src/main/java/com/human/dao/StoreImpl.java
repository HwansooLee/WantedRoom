package com.human.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.human.VO.StoreVO;

@Repository
public class StoreImpl implements IF_StoreDAO{
	private static final String mapperQuery = "com.human.dao.IF_StoreDAO";
	@Inject
	private SqlSession sqlSession;

	@Override
	public void insertStore(StoreVO svo) throws Exception {
		sqlSession.insert(mapperQuery+".insert", svo);
	}

	@Override
	public List<StoreVO> selectStoreAll(String searchAddr) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
