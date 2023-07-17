package com.human.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.human.VO.LikesVO;
import com.human.VO.PageVO;
import com.human.VO.ReplyVO;

@Repository
public class ReplyImpl implements IF_ReplyDAO{
	private final static String mapperQuery = "com.human.dao.IF_ReplyDAO";
	
	@Inject
	private SqlSession sqlSession;

	@Override
	public void insertReply(ReplyVO rvo) throws Exception {
		sqlSession.insert(mapperQuery+".insert",rvo);
	}

	@Override
	public List<ReplyVO> selectReplyAll(PageVO pvo) throws Exception {
		return sqlSession.selectList(mapperQuery+".listAll",pvo);
	}

	@Override
	public void deleteReply(int rno) throws Exception {
		sqlSession.delete(mapperQuery+".delete",rno);
	}

	@Override
	public int replyCnt(int boardNo) throws Exception {
		return sqlSession.selectOne(mapperQuery+".replyCnt",boardNo);
	}

	@Override
	public void updateLikes(LikesVO lvo) throws Exception {
		sqlSession.update(mapperQuery+".updateLikesCnt",lvo);
	}

	@Override
	public List<ReplyVO> myReplyAll(PageVO pvo) throws Exception {
		return sqlSession.selectList(mapperQuery+".mylist",pvo);
	}

	@Override
	public int myReplyCnt(String id) throws Exception {
		return sqlSession.selectOne(mapperQuery+".myReplyCnt",id);
	}
}
