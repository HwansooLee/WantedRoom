package com.human.dao;

import com.human.VO.FavoriteVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.util.List;

@Repository
public class FavoriteImpl implements IF_FavoriteDAO{
    private static final String mapperQuery = "com.human.dao.IF_FavoriteDAO";
    @Inject
    private SqlSession sqlSession;

    @Override
    public void insert(FavoriteVO vo) {
//        sqlSession.insert(mapperQuery + ".insert", vo);
    }

    @Override
    public List<FavoriteVO> selectAll(String id) {
//        return sqlSession.selectList(mapperQuery + ".selectAll", id);
    	return null;
    }
}
