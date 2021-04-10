package com.kh.jsp.board.model.dao;

import static com.kh.jsp.common.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.kh.jsp.board.model.vo.Board;

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

	public Board selectOne(Connection con, int bno) {
		Board b = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = prop.getProperty("selectOne");
		
		try {
			
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, bno);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				b = new Board();
				
				b.setBno(bno);
				b.setBtype(rs.getInt("btype"));
				b.setBtitle(rs.getString("btitle"));
				b.setBcontent(rs.getString("bcontent"));
				b.setBwriter(rs.getString("username"));
				b.setUserId(rs.getString("bwriter"));
				b.setBcount(rs.getInt("bcount"));
				b.setBoardfile(rs.getString("boardfile"));
				b.setBdate(rs.getDate("bdate"));
				
			}
			
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			close(rs);
			close(ps);
		}
		
		return b;
	}

	public int updateReadCount(Connection con, int bno) {

		int result = 0; // 결과를 담기 위한 변수 ( 'n'행이 실행 되었습니다.)
		
		PreparedStatement ps = null; // SQL 실행을 위한 객체
		
		String sql = prop.getProperty("updateReadCount");
		
		try {
			
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, bno);
			
			// SQL 실행!
			// .executeQuery() : SELECT
			// .executeUpdate() : INSERT / UPDATE / DELETE
			
			result = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();

		} finally {
			close(ps);
		}
		
		return result;
	}

}






