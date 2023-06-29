package com.human.dao;

import com.human.VO.ItemAttachVO;

import java.util.List;

public interface IF_ItemAttachDAO {
    public void insert(ItemAttachVO vo);
    public List<ItemAttachVO> selectAll(int itemNo);
}
