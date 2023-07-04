package com.human.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.human.VO.BoardVO;
import com.human.VO.PageVO;

@Repository
public class BoardImpl implements IF_BoardDAO{
    private final static String mapperQuery = "com.human.dao.IF_BoardDAO";
    @Inject
    private SqlSession sqlSession;

    @Override
    public void insert(BoardVO vo) throws Exception{
        sqlSession.insert(mapperQuery + ".insert", vo);
    }

    @Override
    public BoardVO selectOne(int boardNo) throws Exception{
        return sqlSession.selectOne(mapperQuery + ".selectOne", boardNo);
    }

    @Override
    public List<BoardVO> selectAll(PageVO pvo) throws Exception{
        return sqlSession.selectList(mapperQuery + ".selectAll", pvo);
    }

	@Override
	public int boardCnt(String sword) throws Exception {
		return sqlSession.selectOne(mapperQuery+".boardCnt",sword);
	}

	@Override
	public void viewCnt(int boardNo) throws Exception {
		sqlSession.update(mapperQuery+".viewCnt",boardNo);
	}

	@Override
	public int myBoardCnt(String id) throws Exception {
		return sqlSession.selectOne(mapperQuery+".myListCnt",id);
	}

	@Override
	public List<BoardVO> myBoardList(PageVO pvo) throws Exception {
		return sqlSession.selectList(mapperQuery+".mylist",pvo);
	}
}
