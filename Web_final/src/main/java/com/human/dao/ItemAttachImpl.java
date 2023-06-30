package com.human.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.util.List;

@Repository
public class ItemAttachImpl implements IF_ItemAttachDAO{
    private final static String mapperQuery = "com.human.dao.IF_ItemAttachDAO";
    @Inject
    private SqlSession sqlSession;

}
