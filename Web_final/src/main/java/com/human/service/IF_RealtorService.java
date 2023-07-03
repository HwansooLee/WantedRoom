package com.human.service;

import java.util.ArrayList;
import java.util.List;

import com.human.VO.BoardVO;
import com.human.VO.ItemVO;
import com.human.VO.LikesVO;
import com.human.VO.MemberVO;
import com.human.VO.PageVO;
import com.human.VO.ReplyVO;
import org.springframework.web.multipart.MultipartFile;

public interface IF_RealtorService {
    public void addItem(ItemVO ivo, ArrayList<String> fileNames) throws Exception;
    public void addBoard(BoardVO bvo) throws Exception;
	public int boardCnt(String sword) throws Exception;
	public List<BoardVO> listAll(PageVO pvo) throws Exception;
	public BoardVO boardDetail(int boardNo) throws Exception;
	public void addReply(ReplyVO rvo) throws Exception;
	public int replyCnt(int boardNo) throws Exception;
	public List<ReplyVO> getReplyList(PageVO pvo) throws Exception;
    public List<ItemVO> getItemList(String searchWord) throws Exception;
	public ItemVO getItemDetail(int itemNo) throws Exception;
	public List<String> getAttachFileNames(int itemNo) throws Exception;
	public void deleteItem(int itemNo) throws Exception;
	public void modifyItem(ItemVO ivo, ArrayList<String> fileNames) throws Exception;
	public void likesFlag(LikesVO lvo) throws Exception;
	public boolean nicknameChk(String nickname) throws Exception;
	public void insertMember(MemberVO mvo) throws Exception;
	public MemberVO idChk(String id) throws Exception;
}
