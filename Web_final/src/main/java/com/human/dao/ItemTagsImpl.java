package com.human.dao;

import com.human.VO.ItemTagsVO;
import org.apache.ibatis.session.SqlSession;

import javax.inject.Inject;
import java.util.List;

public class ItemTagsImpl implements IF_ItemTagsDAO{
    private static final String mapperQuery = "com.human.dao.IF_ItemTagsDAO";
    @Inject
    SqlSession sqlSession;

    @Override
    public void insert(ItemTagsVO vo) {
        sqlSession.insert(mapperQuery + ".insert", vo);
    }

    @Override
    public List<ItemTagsVO> selectAll(int itemNo) {
        return sqlSession.selectList(mapperQuery + ".selectAll", itemNo);
    }
}
