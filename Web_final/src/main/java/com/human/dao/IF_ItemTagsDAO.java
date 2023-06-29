package com.human.dao;

import com.human.VO.ItemTagsVO;

import java.util.List;

public interface IF_ItemTagsDAO {
    public void insert(ItemTagsVO vo);
    public List<ItemTagsVO> selectAll(int itemNo);
}
