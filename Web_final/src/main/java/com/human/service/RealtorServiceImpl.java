package com.human.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import com.human.VO.*;
import com.human.dao.*;
import com.human.util.FileDataUtil;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class RealtorServiceImpl implements IF_RealtorService{
	
	@Inject
	IF_BoardDAO boarddao;
	
	@Inject
	IF_ReplyDAO replydao;
	
	@Inject
	IF_LikesDAO likesdao;

	@Inject
	private IF_ItemDAO itemDao;
	@Inject
	private IF_ItemAttachDAO itemAttachDao;
	@Inject
	private IF_ItemTagsDAO itemTagsDao;

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
	public void addLikes(LikesVO lvo) throws Exception {
		likesdao.insert(lvo);
	}

	@Override
	public List<ItemVO> getItemList(String searchWord) throws Exception{
		PageVO pvo = new PageVO();
		pvo.setSword(searchWord);
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
	public void deleteItem(int itemNo) throws Exception {
		itemAttachDao.delete(itemNo);
		itemTagsDao.delete(itemNo);
		itemDao.deleteItem(itemNo);
	}
}
