package com.human.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.human.VO.PageVO;
import com.human.VO.ReplyVO;

@Repository
public class ReplyImpl implements IF_ReplyDAO{
	
	private static String mapperQuery = "com.human.dao.IF_ReplyDAO";
	
	@Inject
	private SqlSession sqlSession;

	@Override
	public void insertReply(ReplyVO rvo) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<ReplyVO> selectReplyAll(PageVO pvo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ReplyVO selectReplyOne(int rno) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteReply(int rno) throws Exception {
		// TODO Auto-generated method stub
		
	}

}
