package com.human.VO;

public class ReplyVO {
    private int replyNo;
    private String id;
    private int boardNo;
    private String content;
    private String inDate;
    private int likes;
    private String nickname;
    private Integer likesNo; // 좋아요한 댓글 번호

    public Integer getLikesNo() {
		return likesNo;
	}

	public void setLikesNo(Integer likesNo) {
		this.likesNo = likesNo;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public int getReplyNo() {
        return replyNo;
    }

    public void setReplyNo(int replyNo) {
        this.replyNo = replyNo;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getBoardNo() {
        return boardNo;
    }

    public void setBoardNo(int boardNo) {
        this.boardNo = boardNo;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getInDate() {
        return inDate;
    }

    public void setInDate(String inDate) {
        this.inDate = inDate;
    }

    public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }
}
