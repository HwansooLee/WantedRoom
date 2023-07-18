package com.human.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.human.VO.MemberVO;
import com.human.VO.PageVO;

@Repository
public class MemberImpl implements IF_MemberDAO{
	
	private static String mapperQuery = "com.human.dao.IF_MemberDAO";
	
	@Inject
	private SqlSession sqlSession;

	@Override
	public void insertMember(MemberVO mvo) throws Exception {
		sqlSession.insert(mapperQuery+".insert",mvo);
	}

	@Override
	public MemberVO selectMemberOne(String id) throws Exception {
		return sqlSession.selectOne(mapperQuery+".selectOne",id);
	}

	@Override
	public void updateId(MemberVO mvo) throws Exception {
		sqlSession.update(mapperQuery+".update",mvo);
	}

	@Override
	public String nicknameChk(String nickname) throws Exception {
		return sqlSession.selectOne(mapperQuery+".nicknameChk",nickname);
	}

}
