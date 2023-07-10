package com.human.dao;

import java.util.List;

import javax.inject.Inject;

import com.human.util.BoundCoords;
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
	public List<StoreVO> selectStoreAll(BoundCoords bound) throws Exception {
		System.out.println("doing select");
		return sqlSession.selectList(mapperQuery+".selectNearbyStore", bound);
	}

}
