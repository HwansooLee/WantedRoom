package com.human.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.human.VO.BoardVO;
import com.human.VO.ItemVO;
import com.human.VO.PageVO;
import com.human.dao.IF_BoardDAO;

@Service
public class RealtorServiceImpl implements IF_RealtorService{
	
	@Inject
	IF_BoardDAO boarddao;

    @Override
    public void addItem(ItemVO ivo) {

    }

	@Override
	public void addBoard(BoardVO bvo) throws Exception {
		boarddao.insert(bvo);
	}

	@Override
	public int boardCnt(String sword) throws Exception {
		return boarddao.boardCnt(sword);
	}

	@Override
	public List<BoardVO> listAll(PageVO pvo) throws Exception {
		return boarddao.selectAll(pvo);
	}
}
