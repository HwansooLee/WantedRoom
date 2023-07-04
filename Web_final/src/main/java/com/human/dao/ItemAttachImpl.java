package com.human.dao;

import com.human.VO.ItemAttachVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.util.ArrayList;
import java.util.List;

@Repository
public class ItemAttachImpl implements IF_ItemAttachDAO{
    private final static String mapperQuery = "com.human.dao.IF_ItemAttachDAO";
    @Inject
    private SqlSession sqlSession;

    @Override
    public void insert(ItemAttachVO attachVo) {
        sqlSession.insert(mapperQuery+".insert", attachVo);
    }

    @Override
    public void insertMultiple(int itemNo, ArrayList<String> fileNames) {
        for(String s:fileNames)
            insert(new ItemAttachVO(itemNo, s));
    }

    @Override
    public List<ItemAttachVO> selectAll(int itemNo) {
        return sqlSession.selectList(mapperQuery+".selectAll", itemNo);
    }

    @Override
    public void delete(int itemNo) {
        sqlSession.delete(mapperQuery+".delete", itemNo);
    }

    @Override
    public void deleteByName(String fileName) {
        sqlSession.delete(mapperQuery+".deleteByName", fileName);
    }
}
