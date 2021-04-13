package com.kh.jsp.thumb.model.service;

import java.sql.*;
import java.util.ArrayList;

import com.kh.jsp.thumb.model.dao.ThumbnailDAO;
import com.kh.jsp.thumb.model.vo.Thumbnail;

import static com.kh.jsp.common.JDBCTemplate.*;

public class ThumbnailService {

	private Connection con;
	private ThumbnailDAO dao = new ThumbnailDAO();
	
	public ArrayList<Thumbnail> selectList() {
		con = getConnection();
		
		ArrayList<Thumbnail> list = dao.selectList(con);
		
		close(con);
		
		return list;
	}
	
	
	
	
	
	
	
}
