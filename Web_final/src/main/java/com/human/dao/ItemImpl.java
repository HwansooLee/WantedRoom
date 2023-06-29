package com.human.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.human.VO.ItemVO;
import com.human.VO.PageVO;

@Repository
public class ItemImpl implements IF_ItemDAO{
	
	private static String mapperQuery = "com.human.dao.IF_ItemDAO";
	
	@Inject
	private SqlSession sqlSession;

	@Override
	public void insertItem(ItemVO ivo) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<ItemVO> selectItemAll(PageVO pvo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ItemVO selectItemOne(int ino) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteItem(int ino) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateItem(ItemVO ivo) throws Exception {
		// TODO Auto-generated method stub
		
	}

}
