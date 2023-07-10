package com.human.dao;

import java.util.List;

import com.human.VO.StoreVO;
import com.human.util.BoundCoords;

public interface IF_StoreDAO {
	public void insertStore(StoreVO svo) throws Exception;
	public List<StoreVO> selectStoreAll(BoundCoords bound) throws Exception;
}
