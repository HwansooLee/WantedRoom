package com.human.dao;

import java.util.List;

import com.human.VO.ItemVO;
import com.human.VO.PageVO;

public interface IF_ItemDAO {
	// page
	public void insertItem(ItemVO ivo) throws Exception;
	public List<ItemVO> selectItemAll(PageVO pvo) throws Exception;
	public ItemVO selectItemOne(int ino) throws Exception;
	public void deleteItem(int ino) throws Exception;
	public void updateItem(ItemVO ivo) throws Exception;
	public void updateItemAsSold(int itemNo);
    public int getNextItemNo();
}
