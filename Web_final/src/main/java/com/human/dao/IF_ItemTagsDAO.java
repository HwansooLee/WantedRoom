package com.human.dao;

import com.human.VO.ItemTagsVO;

import java.util.List;

public interface IF_ItemTagsDAO {
    public void insert(ItemTagsVO tagsVo);
    public void delete(int itemNo);
}
