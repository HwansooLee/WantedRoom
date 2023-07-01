package com.human.dao;

import java.util.List;

import com.human.VO.PageVO;
import com.human.VO.ReplyVO;

public interface IF_ReplyDAO {
	// page
	public void insertReply(ReplyVO rvo) throws Exception;
	public List<ReplyVO> selectReplyAll(PageVO pvo) throws Exception;
	public ReplyVO selectReplyOne(int rno) throws Exception;
	public void deleteReply(int rno) throws Exception;
	public int replyCnt(int boardNo) throws Exception;
}
