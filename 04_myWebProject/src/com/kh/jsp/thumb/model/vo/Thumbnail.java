package com.kh.jsp.thumb.model.vo;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;

import com.kh.jsp.board.model.vo.Board;

public class Thumbnail extends Board implements Serializable{

	private static final long serialVersionUID = 827L;

	private ArrayList<Attachment> attList;

	public Thumbnail() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Thumbnail(int bno, int btype, String btitle, String bcontent, String bwriter, String userId, int bcount,
			String boardfile, Date bdate, String status) {
		super(bno, btype, btitle, bcontent, bwriter, userId, bcount, boardfile, bdate, status);
		// TODO Auto-generated constructor stub
	}

	public Thumbnail(String btitle, String bcontent, String userId, String boardfile) {
		super(btitle, bcontent, userId, boardfile);
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return "Thumbnail [attList=" + attList + "]";
	}

	public ArrayList<Attachment> getAttList() {
		return attList;
	}

	public void setAttList(ArrayList<Attachment> attList) {
		this.attList = attList;
	}
	
	
	
	
}
