package com.human.dao;

import com.human.VO.ItemTagsVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.util.List;

@Repository
public class ItemTagsImpl implements IF_ItemTagsDAO{
    private static final String mapperQuery = "com.human.dao.IF_ItemTagsDAO";
    @Inject
    private SqlSession sqlSession;

    @Override
    public void insert(ItemTagsVO tagsVo) {
        sqlSession.insert(mapperQuery+".insert", tagsVo);
    }

    @Override
    public void delete(int itemNo) {
        sqlSession.delete(mapperQuery+".delete", itemNo);
    }
}
