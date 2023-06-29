package com.human.dao;

import com.human.VO.BoardVO;
import org.apache.ibatis.session.SqlSession;

import javax.inject.Inject;
import java.util.List;

public class BoardImpl implements IF_BoardDAO{
    private final static String mapperQuery = "com.human.dao.IF_BoardVO";
    @Inject
    SqlSession sqlSession;

    @Override
    public void insert(BoardVO vo) {
        sqlSession.insert(mapperQuery + ".insert", vo);
    }

    @Override
    public BoardVO selectOne(int boardNo) {
        return sqlSession.selectOne(mapperQuery + ".selectOne", boardNo);
    }

    @Override
    public List<BoardVO> selectAll(String searchWord) {
        return sqlSession.selectList(mapperQuery + ".selectOne", searchWord);
    }
}
