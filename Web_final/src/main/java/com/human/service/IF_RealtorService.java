package com.human.service;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;

import com.human.VO.BoardVO;
import com.human.VO.ItemVO;
import com.human.VO.LikesVO;
import com.human.VO.MemberVO;
import com.human.VO.PageVO;
import com.human.VO.ReplyVO;

public interface IF_RealtorService {
    public void addItem(ItemVO ivo, ArrayList<String> fileNames) throws Exception;
    public void addBoard(BoardVO bvo) throws Exception;
	public int boardCnt(String sword) throws Exception;
	public List<BoardVO> listAll(PageVO pvo) throws Exception;
	public BoardVO boardDetail(int boardNo) throws Exception;
	public void addReply(ReplyVO rvo) throws Exception;
	public int replyCnt(int boardNo) throws Exception;
	public List<ReplyVO> getReplyList(PageVO pvo) throws Exception;
    public List<ItemVO> getItemList(PageVO pvo) throws Exception;
	public ItemVO getItemDetail(int itemNo) throws Exception;
	public List<String> getAttachFileNames(int itemNo) throws Exception;
	public void deleteAttach(String fileName);
	public void deleteItem(int itemNo) throws Exception;
	public void modifyItem(ItemVO ivo, ArrayList<String> fileNames) throws Exception;
	public void setItemSold(int itemNo);
	public void likesFlag(LikesVO lvo) throws Exception;
	public boolean nicknameChk(String nickname) throws Exception;
	public void insertMember(MemberVO mvo) throws Exception;
	public MemberVO idChk(MemberVO mvo) throws Exception;
	public int getCnt(String sword, String id);
	public int myBoardCnt(String id) throws Exception;
	public List<BoardVO> myList(PageVO pvo) throws Exception;
	public BoardVO getBoardOne(int boardNo) throws Exception;
	public void modBoard(BoardVO bvo) throws Exception;
	public void delBoard(int boardNo) throws Exception;
	public List<ReplyVO> getMyReplyList(PageVO pvo) throws Exception;
	public int myReplyCnt(String id) throws Exception;
	public void delReply(int replyNo) throws Exception;
	public void regRealtorNo(MemberVO mvo) throws Exception;
	public JSONObject getChartData(int itemNo) throws Exception;
	public boolean reIdChk(MemberVO mvo) throws Exception;
}
