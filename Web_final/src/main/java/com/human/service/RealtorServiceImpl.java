package com.human.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import com.human.VO.BoardVO;
import com.human.VO.ItemAttachVO;
import com.human.VO.ItemTagsVO;
import com.human.VO.ItemVO;
import com.human.VO.LikesVO;
import com.human.VO.MemberVO;
import com.human.VO.PageVO;
import com.human.VO.ReplyVO;
import com.human.dao.IF_BoardDAO;
import com.human.dao.IF_ItemAttachDAO;
import com.human.dao.IF_ItemDAO;
import com.human.dao.IF_ItemTagsDAO;
import com.human.dao.IF_LikesDAO;
import com.human.dao.IF_MemberDAO;
import com.human.dao.IF_ReplyDAO;
import com.human.util.ChartProcess;
import com.human.util.TextProcess;

@Service
public class RealtorServiceImpl implements IF_RealtorService{
	
	@Inject
	private IF_BoardDAO boarddao;
	
	@Inject
	private IF_ReplyDAO replydao;
	
	@Inject
	private IF_LikesDAO likesdao;
	
	@Inject
	private IF_MemberDAO memberdao;

	@Inject
	private IF_ItemDAO itemDao;
	@Inject
	private IF_ItemAttachDAO itemAttachDao;
	@Inject
	private IF_ItemTagsDAO itemTagsDao;
	@Inject
	private TextProcess textProcess;
	@Inject
	private ChartProcess chartProcess;

    @Override
    public void addItem(ItemVO ivo, ArrayList<String> fileNames) throws Exception{
		int itemNo = itemDao.getNextItemNo();
		ivo.setItemNo(itemNo);
		itemDao.insertItem(ivo);
		ItemTagsVO tagsVo = new ItemTagsVO(ivo);
		itemTagsDao.insert(tagsVo);
		itemAttachDao.insertMultiple(itemNo, fileNames);
    }

	@Override
	public void addBoard(BoardVO bvo) throws Exception {
		bvo.setSentiment( textProcess.getEmotion(bvo.getContent()) );
		boarddao.insert(bvo);
	}

	@Override
	public int boardCnt(String sword) throws Exception {
		return boarddao.boardCnt(sword);
	}

	@Override
	public List<BoardVO> listAll(PageVO pvo) throws Exception {
		return boarddao.selectAll(pvo);
	}

	@Override
	public BoardVO boardDetail(int boardNo) throws Exception {
		boarddao.viewCnt(boardNo);
		return boarddao.selectOne(boardNo);
	}

	@Override
	public void addReply(ReplyVO rvo) throws Exception {
		replydao.insertReply(rvo);
	}

	@Override
	public int replyCnt(int boardNo) throws Exception {
		return replydao.replyCnt(boardNo);
	}

	@Override
	public List<ReplyVO> getReplyList(PageVO pvo) throws Exception {
		return replydao.selectReplyAll(pvo);
	}

	@Override
	public void likesFlag(LikesVO lvo) throws Exception {
		if(lvo.isFlag()) { // 좋아요한 경우
			likesdao.insert(lvo);
		}else { // 좋아요 취소한경우
			likesdao.delete(lvo);
		}
		// 좋아요수 갱신
		replydao.updateLikes(lvo);
	}

	@Override
	public boolean nicknameChk(String nickname) throws Exception {
		String temp = memberdao.nicknameChk(nickname);
		if(temp == null || temp.isEmpty()) {
			return true;
		}
		return false;
		
	}

	@Override
	public void insertMember(MemberVO mvo) throws Exception {
		memberdao.insertMember(mvo);
	}

	@Override
	public List<ItemVO> getItemList(PageVO pvo) throws Exception{
		return itemDao.selectItemAll(pvo);
	}

	@Override
	public ItemVO getItemDetail(int itemNo) throws Exception{
		return itemDao.selectItemOne(itemNo);
	}

	@Override
	public List<String> getAttachFileNames(int itemNo) throws Exception {
		List<ItemAttachVO> attachs = itemAttachDao.selectAll(itemNo);
		List<String> fileNames = new ArrayList<>();
		for(ItemAttachVO attachVo:attachs)
			fileNames.add(attachVo.getFileName());
		return fileNames;
	}

	@Override
	public void deleteAttach(String fileName) {
		itemAttachDao.deleteByName(fileName);
	}

	@Override
	public void deleteItem(int itemNo) throws Exception {
		itemAttachDao.delete(itemNo);
		itemTagsDao.delete(itemNo);
		itemDao.deleteItem(itemNo);
	}

	@Override
	public void modifyItem(ItemVO ivo, ArrayList<String> fileNames) throws Exception {
		if( fileNames.size() > 0 )
			itemAttachDao.insertMultiple(ivo.getItemNo(), fileNames);
		itemDao.updateItem(ivo);
	}

	@Override
	public void setItemSold(int itemNo) {
		itemDao.updateItemAsSold(itemNo);
	}

	@Override
	public MemberVO idChk(MemberVO mvo) throws Exception {
		MemberVO nowvo = memberdao.selectMemberOne(mvo.getId());
		if(nowvo != null && nowvo.getPwd().equals(mvo.getPwd())) {
			return nowvo;
		}
		return null;
	}

	@Override
	public int getCnt(String sword, String id) {
		return itemDao.selectItemCnt(sword, id);
	}

	@Override
	public int myBoardCnt(String id) throws Exception {
		return boarddao.myBoardCnt(id);
	}

	@Override
	public List<BoardVO> myList(PageVO pvo) throws Exception {
		return boarddao.myBoardList(pvo);
	}

	@Override
	public BoardVO getBoardOne(int boardNo) throws Exception {
		return boarddao.selectOne(boardNo);
	}

	@Override
	public void modBoard(BoardVO bvo) throws Exception {
		bvo.setSentiment( textProcess.getEmotion( bvo.getContent() ) );
		boarddao.modify(bvo);
	}

	@Override
	public void delBoard(int boardNo) throws Exception {
		boarddao.delete(boardNo);
	}

	@Override
	public List<ReplyVO> getMyReplyList(PageVO pvo) throws Exception {
		return replydao.myReplyAll(pvo);
	}

	@Override
	public int myReplyCnt(String id) throws Exception {
		return replydao.myReplyCnt(id);
	}

	@Override
	public void delReply(int replyNo) throws Exception {
		replydao.deleteReply(replyNo);
	}

	@Override
	public void regRealtorNo(MemberVO mvo) throws Exception {
		memberdao.updateId(mvo);
	}

	@Override
	public JSONObject getChartData(int itemNo) throws Exception {
		/* query)
		 * select b.sentiment, count(b.sentiment) cnt 
		 * from board b , item i 
		 * where b.bcode = i.bcode 
		 * and itemNo = 14 
		 * GROUP by b.sentiment
		 * 
		 * dao로 위 쿼리를 실행을 시킨 결과를 받아와서
		 * 그 결과를 JSONObject로 변환후 리턴
		 */
		List<BoardVO> cntList = boarddao.getItemSentimentCnt(itemNo); // 실행시킨 결과 리스트	
		return chartProcess.getChartData(cntList);
	}

	@Override
	public boolean reIdChk(MemberVO mvo) throws Exception {
		if(memberdao.selectMemberOne(mvo.getId()) != null) { // 존재하는 아이디라면 true
			return true;
		}
		return false;
	}
}
