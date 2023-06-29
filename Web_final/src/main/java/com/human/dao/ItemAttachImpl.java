package com.human.dao;

import com.human.VO.ItemAttachVO;
import org.apache.ibatis.session.SqlSession;

import javax.inject.Inject;
import java.util.List;

public class ItemAttachImpl implements IF_ItemAttachDAO{
    private final static String mapperQuery = "com.human.dao.IF_ItemAttachDAO";
    @Inject
    SqlSession sqlSession;

    @Override
    public void insert(ItemAttachVO vo) {
        sqlSession.insert(mapperQuery + ".insert", vo);
    }

    @Override
    public List<ItemAttachVO> selectAll(int itemNo) {
        return sqlSession.selectList(mapperQuery + ".selectAll", itemNo);
    }
}
