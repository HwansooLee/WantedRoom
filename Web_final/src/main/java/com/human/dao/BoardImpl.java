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
//        return sqlSession.selectOne(mapperQuery + ".selectOne", boardNo);
    	return null;
    }

    @Override
    public List<BoardVO> selectAll(PageVO pvo) throws Exception{
        return sqlSession.selectList(mapperQuery + ".selectAll", pvo);
    }

	@Override
	public int boardCnt(String sword) throws Exception {
		return sqlSession.selectOne(mapperQuery+".boardCnt",sword);
	}
}
