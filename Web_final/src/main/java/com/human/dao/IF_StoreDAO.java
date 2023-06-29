package com.human.dao;

import java.util.List;

import com.human.VO.StoreVO;

public interface IF_StoreDAO {
	public void insertStore(StoreVO svo) throws Exception;
	public List<StoreVO> selectStoreAll(String searchAddr) throws Exception; // like '%searchAddr%'
}
