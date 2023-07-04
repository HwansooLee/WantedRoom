package com.human.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.human.VO.ItemVO;
import com.human.VO.PageVO;

@Repository
public class ItemImpl implements IF_ItemDAO{
	
	private static final String mapperQuery = "com.human.dao.IF_ItemDAO";
	
	@Inject
	private SqlSession sqlSession;

	@Override
	public void insertItem(ItemVO ivo) throws Exception {
		sqlSession.insert(mapperQuery+".insert", ivo);
	}

	@Override
	public List<ItemVO> selectItemAll(PageVO pvo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(mapperQuery+".selectAll", pvo);
	}

	@Override
	public ItemVO selectItemOne(int ino) throws Exception {
		return sqlSession.selectOne(mapperQuery+".select", ino);
	}

	@Override
	public void deleteItem(int ino) throws Exception {
		sqlSession.delete(mapperQuery+".delete", ino);
	}

	@Override
	public void updateItem(ItemVO ivo) throws Exception {
		sqlSession.update(mapperQuery+".update", ivo);
	}

	@Override
	public void updateItemAsSold(int itemNo) {
		sqlSession.update(mapperQuery+".updateStatusSold", itemNo);
	}

	@Override
	public int getNextItemNo() {
		return sqlSession.selectOne(mapperQuery+".selectNextVal");
	}

}
