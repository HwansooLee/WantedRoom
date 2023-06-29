package com.human.dao;

import com.human.VO.BoardVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.util.List;

@Repository
public class BoardImpl implements IF_BoardDAO{
    private final static String mapperQuery = "com.human.dao.IF_BoardDAO";
    @Inject
    private SqlSession sqlSession;

    @Override
    public void insert(BoardVO vo) {
//        sqlSession.insert(mapperQuery + ".insert", vo);
    }

    @Override
    public BoardVO selectOne(int boardNo) {
//        return sqlSession.selectOne(mapperQuery + ".selectOne", boardNo);
    	return null;
    }

    @Override
    public List<BoardVO> selectAll(String searchWord) {
//        return sqlSession.selectList(mapperQuery + ".selectAll", searchWord);
    	return null;
    }
}
