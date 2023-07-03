package com.human.dao;

import java.util.List;

import com.human.VO.MemberVO;
import com.human.VO.PageVO;

public interface IF_MemberDAO {
	public void insertMember(MemberVO mvo) throws Exception;
	public List<MemberVO> selectMemberAll(PageVO pvo)throws Exception;
	public MemberVO selectMemberOne(String id) throws Exception;
	public void deleteId(String id) throws Exception;
	public void updateId(MemberVO mvo) throws Exception;
	public String nicknameChk(String nickname) throws Exception;
}
