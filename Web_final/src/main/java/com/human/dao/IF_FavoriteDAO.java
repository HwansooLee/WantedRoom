package com.human.dao;

import com.human.VO.FavoriteVO;

import java.util.List;

public interface IF_FavoriteDAO {
    public void insert(FavoriteVO vo);
    public List<FavoriteVO> selectAll(String id);
}
