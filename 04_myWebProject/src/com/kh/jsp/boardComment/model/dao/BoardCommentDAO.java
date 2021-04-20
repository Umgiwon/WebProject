package com.kh.jsp.boardComment.model.dao;

import static com.kh.jsp.common.JDBCTemplate.*;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.kh.jsp.boardComment.model.vo.BoardComment;

public class BoardCommentDAO {
	private Properties prop;
	
	public BoardCommentDAO() {
		prop = new Properties();
		
		String filePath = BoardCommentDAO.class
				          .getResource("/config/comment.properties")
				          .getPath();
		
		try {
			
			prop.load(new FileReader(filePath));
			
		} catch (FileNotFoundException e) {

			e.printStackTrace();
		} catch (IOException e) {

			e.printStackTrace();
		}
		
	}

	public int insertComment(Connection con, BoardComment comment) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("insertComment");
		
		try {
			pstmt = con.prepareStatement(sql);
		
			pstmt.setInt(1, comment.getBno());
			pstmt.setString(2, comment.getCcontent());
			pstmt.setString(3, comment.getCwriter());
			// 첫 댓글은 참조하는 댓글이 없다.
			// 따라서 refcno 가 0으로 온다.
			if(comment.getRefcno() > 0 ) {
				pstmt.setInt(4, comment.getRefcno());
			} else {
				pstmt.setNull(4, java.sql.Types.NULL);
			}
			
			pstmt.setInt(5, comment.getClevel());
			
			result = pstmt.executeUpdate();			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public ArrayList<BoardComment> selectList(Connection con, int bno) {
		
		ArrayList<BoardComment> clist = new ArrayList<>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = prop.getProperty("selectList");
		
		try {
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, bno);

			rs = ps.executeQuery();
			
			while(rs.next()) {
				BoardComment bco = new BoardComment();
				
				bco.setCno(   rs.getInt(1) );
				bco.setBno(   rs.getInt(2) );
				bco.setCcontent( rs.getString(3));
				bco.setCwriter( rs.getString("username"));
				bco.setUserId( rs.getString("cwriter"));
				bco.setCdate( rs.getDate("cdate"));
				bco.setRefcno(rs.getInt("ref_cno"));
				bco.setClevel(rs.getInt("clevel"));
				
				clist.add(bco);				
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			close(rs);
			close(ps);
		}		
		
		return clist;
	}

	public int updateComment(Connection con, BoardComment bco) {
		int result = 0;
		PreparedStatement ps = null;
		
		String sql = prop.getProperty("updateComment");
		
		try {
			ps = con.prepareStatement(sql);
			
			ps.setString(1, bco.getCcontent());
			ps.setInt(2, bco.getCno());
			
			result = ps.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		
		} finally {
			close(ps);
		}
				
		return result;
	}

	public int deleteComment(Connection con, int cno) {
		
		int result = 0;
		PreparedStatement ps = null;
		
		String sql = prop.getProperty("deleteComment");
		
		try {
			
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, cno);
			
			result = ps.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			
			close(ps);
		}
				
		return result;
	}
	
	
	
	
	
	
}










