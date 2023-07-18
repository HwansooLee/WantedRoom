package com.human.VO;

public class PageVO {
	
	private Integer page;
	private int totalCount;
	
	private int startNo;
	private int endNo;
	private int startPage;
	private int endPage;
	
	private boolean prev;
	private boolean next;
	
	private String sword;
	private String sorted; // 정렬기준
	
	private int boardNo; // 댓글 목록 받아오기 위한 boardNo
	private int itemNo;
	private String nowUser; // 쿼리문을 위한 장치 아이디를 의미
	
	public String getNowUser() {
		return nowUser;
	}

	public void setNowUser(String nowUser) {
		this.nowUser = nowUser;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public String getSorted() {
		return sorted;
	}

	public void setSorted(String sorted) {
		this.sorted = sorted;
	}

	public String getSword() {
		return sword;
	}

	public void setSword(String sword) {
		this.sword = sword;
	}

	public void calPage() {
		final int perPageNum = 5;
		final int perPostNum = 12;
		// 현재 페이지의 첫번째 글의 번호
		startNo = (page - 1)*perPostNum + 1;
		// 현재 페이지그룹의 마지막 페이지
		int temp = (int)(Math.ceil(page/(double)perPageNum)*perPageNum);
		// 게시글 수에 따른 마지막 페이지 보정 작업
		endPage = (temp*perPostNum > totalCount) ? (int) Math.ceil(totalCount/(double)perPostNum) : temp;
		startPage = temp - perPageNum + 1;
		// 현재 페이지의 마지막 글의 번호
		endNo = (page*perPostNum > totalCount) ? totalCount : page*perPostNum;
		prev = startPage != 1;
		next = endPage*perPostNum < totalCount;
	}
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getStartNo() {
		return startNo;
	}
	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}
	public int getEndNo() {
		return endNo;
	}
	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	
	
}
