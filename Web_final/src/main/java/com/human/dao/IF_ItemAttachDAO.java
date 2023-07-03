package com.human.dao;

import com.human.VO.ItemAttachVO;

import java.util.ArrayList;
import java.util.List;

public interface IF_ItemAttachDAO {
    public void insert(ItemAttachVO attachVo);
    public void insertMultiple(int itemNo, ArrayList<String> fileNames);
    public List<ItemAttachVO> selectAll(int itemNo);
    public void delete(int itemNo);
}
