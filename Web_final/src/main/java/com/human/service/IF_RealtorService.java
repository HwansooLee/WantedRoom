package com.human.service;

import java.util.List;

import com.human.VO.BoardVO;
import com.human.VO.ItemVO;
import com.human.VO.PageVO;

public interface IF_RealtorService {
    public void addItem(ItemVO ivo);
    public void addBoard(BoardVO bvo) throws Exception;
	public int boardCnt(String sword) throws Exception;
	public List<BoardVO> listAll(PageVO pvo) throws Exception;
	public BoardVO boardDetail(int boardNo) throws Exception;
}
