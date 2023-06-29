package com.human.dao;

import com.human.VO.BoardVO;

import java.util.List;

public interface IF_BoardDAO {
    // page
    public void insert(BoardVO vo);
    public BoardVO selectOne(int boardNo);
    public List<BoardVO> selectAll(String searchWord);
}
