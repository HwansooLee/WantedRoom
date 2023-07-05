package com.human.dao;

import java.util.List;

import com.human.VO.BoardVO;
import com.human.VO.PageVO;

public interface IF_BoardDAO {
    // page
    public void insert(BoardVO vo) throws Exception;
    public BoardVO selectOne(int boardNo) throws Exception;
    public List<BoardVO> selectAll(PageVO pvo) throws Exception;
    public int boardCnt(String sword) throws Exception;
    public void viewCnt(int boardNo) throws Exception;
    public int myBoardCnt(String id) throws Exception;
    public List<BoardVO> myBoardList(PageVO pvo) throws Exception;
    public void modify(BoardVO bvo) throws Exception;
    public void delete(int boardNo) throws Exception;
}
