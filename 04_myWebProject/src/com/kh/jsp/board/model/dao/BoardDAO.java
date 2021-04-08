package com.kh.jsp.board.model.dao;

import java.io.*;
import java.sql.*;
import java.util.*;

import com.kh.jsp.board.model.vo.Board;
import static com.kh.jsp.common.JDBCTemplate.*;

public class BoardDAO {

	private Properties prop;
	
	public BoardDAO() { 
		prop = new Properties();
		
		String filePath = BoardDAO.class
						  .getResource("/config/board.properties")
						  .getPath();
		
		try {
			prop.load(new FileReader(filePath));
			
		} catch (IOException e) {
			
			e.printStackTrace();
		}
	}
	
	public ArrayList<Board> selectList(Connection con) {
		ArrayList<Board> list = new ArrayList<>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = prop.getProperty("selectList");
		
		try {
			
			ps = con.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				Board b = new Board();
				
				b.setBno(rs.getInt("bno") );
				b.setBtype(rs.getInt("btype"));
				b.setBtitle(rs.getString("btitle"));
				b.setBcontent(rs.getString("bcontent"));
				b.setBwriter( rs.getString("username"));
				b.setUserId(rs.getString("bwriter"));
				b.setBcount ( rs.getInt("bcount"));
				b.setBdate(rs.getDate("bdate"));
				b.setBoardfile(rs.getString("boardfile"));
			
				list.add(b);
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			close(rs);
			close(ps);
		}
		
		return list;
	}

	public int insertBoard(Connection con, Board b) {
		int result = 0;
		
		PreparedStatement ps = null;
		
		String sql = prop.getProperty("insertBoard");
		
		try {
			
			ps = con.prepareStatement(sql);
			
			ps.setString(1,  b.getBtitle());
			ps.setString(2,  b.getBcontent());
			ps.setString(3,  b.getUserId());
			ps.setString(4,  b.getBoardfile());
			
			result = ps.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			close(ps);
		}
		
		return result;
	}

}






