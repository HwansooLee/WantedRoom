package com.human.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.human.VO.BoardVO;
import com.human.VO.ItemVO;
import com.human.VO.LikesVO;
import com.human.VO.PageVO;
import com.human.VO.ReplyVO;
import com.human.dao.IF_BoardDAO;
import com.human.dao.IF_LikesDAO;
import com.human.dao.IF_ReplyDAO;

@Service
public class RealtorServiceImpl implements IF_RealtorService{
	
	@Inject
	IF_BoardDAO boarddao;
	
	@Inject
	IF_ReplyDAO replydao;
	
	@Inject
	IF_LikesDAO likesdao;

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

	@Override
	public BoardVO boardDetail(int boardNo) throws Exception {
		boarddao.viewCnt(boardNo);
		return boarddao.selectOne(boardNo);
	}

	@Override
	public void addReply(ReplyVO rvo) throws Exception {
		replydao.insertReply(rvo);
	}

	@Override
	public int replyCnt(int boardNo) throws Exception {
		return replydao.replyCnt(boardNo);
	}

	@Override
	public List<ReplyVO> getReplyList(PageVO pvo) throws Exception {
		return replydao.selectReplyAll(pvo);
	}

	@Override
	public void addLikes(LikesVO lvo) throws Exception {
		likesdao.insert(lvo);
	}
}
