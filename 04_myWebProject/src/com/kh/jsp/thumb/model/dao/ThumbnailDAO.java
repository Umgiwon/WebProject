package com.kh.jsp.thumb.model.dao;

import java.io.*;
import java.sql.*;
import java.util.*;

import com.kh.jsp.thumb.model.vo.Attachment;
import com.kh.jsp.thumb.model.vo.Thumbnail;
import static com.kh.jsp.common.JDBCTemplate.*;

public class ThumbnailDAO {
	private Properties prop;

	public ThumbnailDAO() {
		prop = new Properties();

		String filePath = ThumbnailDAO.class.getResource("/config/thumbnail.properties").getPath();

		try {
			prop.load(new FileReader(filePath));

		} catch (IOException e) {

			e.printStackTrace();
		}

	}

	public ArrayList<Thumbnail> selectList(Connection con) {
		ArrayList<Thumbnail> list = new ArrayList<>();
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = prop.getProperty("selectList");

		try {
			ps = con.prepareStatement(sql);

			rs = ps.executeQuery();

			while (rs.next()) {
				Thumbnail t = new Thumbnail();

				t.setBno(		rs.getInt("bno"));
				t.setBtitle(	rs.getString("btitle"));
				t.setBcontent(	rs.getString("bcontent"));
				t.setBwriter(	rs.getString("username"));
				t.setBcount(	rs.getInt("bcount"));
				t.setBdate(		rs.getDate("bdate"));
				t.setBoardfile(	rs.getString("filename"));

				list.add(t);
			}

		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			close(rs);
			close(ps);
		}

		return list;
	}

	public int insertThumbnail(Connection con, Thumbnail t) {
		int result = 0;
		PreparedStatement ps = null;
		
		String sql = prop.getProperty("insertThumbnail");
		
		try {
			ps = con.prepareStatement(sql);
			
			ps.setString(1, t.getBtitle());
			ps.setString(2, t.getBcontent());
			ps.setString(3, t.getUserId());
			
			result = ps.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			close(ps);
		}
		
		return result;
	}

	public int getCurrentBno(Connection con) {
		int result = 0;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = prop.getProperty("currentBno");
		
		try {
			ps = con.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			if( rs.next()) {
				result = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally { 
			close(rs);
			close(ps);
		}
		
		return result;
	}

	public int insertAttachment(Connection con, Attachment attachment) {
		int result = 0;
		PreparedStatement ps = null;
		String sql = prop.getProperty("insertAttachment");
		
		try {
			ps = con.prepareStatement(sql);
			
			ps.setInt(1,  attachment.getBno());
			ps.setString(2, attachment.getFilename());
			ps.setInt(3, attachment.getFlevel());
			
			result = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(ps);
		}
		
		return result;
	}

	public HashMap<String, Object> selectOne(Connection con, int bno) {
		HashMap<String,Object> map = new HashMap<>();
		ArrayList<Attachment> list = new ArrayList<>();
		Thumbnail t = null;
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = prop.getProperty("selectOne");
		
		try {
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, bno);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				t = new Thumbnail();
				
				t.setBno( rs.getInt("bno"));
				t.setBtitle(rs.getString("btitle"));
				t.setBcontent(rs.getString("bcontent"));
				t.setBwriter(rs.getString("username"));
				t.setUserId(rs.getString("userId"));
				t.setBcount(rs.getInt("bcount"));
				t.setBdate(rs.getDate("bdate"));
				
				// --------------- 여기까지 썸네일!
				
				Attachment a = new Attachment();
				
				a.setFno(rs.getInt("fno"));
				a.setBno(rs.getInt("bno"));
				a.setFilename(rs.getString("filename"));
				a.setFlevel(rs.getInt("flevel"));
				a.setUploadDate(rs.getDate("upload_date"));
				a.setStatus(rs.getString("status"));
				
				list.add(a);
			}
			
			map.put("thumbnail", t);
			map.put("list", list);
						
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			close(rs);
			close(ps);
		}
		
		return map;
	}

	public int updateThumbnail(Connection con, Thumbnail t) {
		int result = 0;
		
		PreparedStatement ps = null;
		
		String sql = prop.getProperty("updateThumbnail");
		
		try {
			ps = con.prepareStatement(sql);
			
			ps.setString(1, t.getBtitle());
			ps.setString(2, t.getBcontent());
			ps.setInt(3, t.getBno());
			
			result = ps.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
			
		} finally {
			
			close(ps);
		}
		
		return result;
	}

	public int updateAttachment(Connection con, Attachment a) {
		
		int result = 0;
		
		PreparedStatement ps = null;
		
		String sql = prop.getProperty("updateAttachment");
		
		try {
			
			ps = con.prepareStatement(sql);
			
			ps.setString(1, a.getFilename());
			ps.setInt(2, a.getFno());
			
			result = ps.executeUpdate();
			
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			close(ps);
		}
		
		return result;
	}

	public int deleteThumbnail(Connection con, int bno) {
		int result = 0;
		PreparedStatement ps = null;
		
		String sql = prop.getProperty("deleteThumbnail");
		
		try {
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, bno);
			
			result = ps.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			close(ps);
		}
		
		return result;
	}

	public int deleteAttachment(Connection con, int bno) {
		int result = 0;
		PreparedStatement ps = null;
		
		String sql = prop.getProperty("deleteAttachment");
		
		try {
			
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, bno);
			
			result = ps.executeUpdate();
			
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			
			close(ps);
		}
		
		return result;
	}

	public String selectFilename(Connection con, int fno) {
		String result = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = prop.getProperty("selectFilename");
		
		try {
			
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, fno);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				result = rs.getString(1);
			}
			
		} catch (SQLException e) {

			e.printStackTrace();
			
		} finally {
			close(rs);
			close(ps);
		}
		
		return result;
	}

	public int deleteOne(Connection con, int fno) {
		int result = 0;
		PreparedStatement ps = null;
		
		String sql = prop.getProperty("deleteOne");
		
		try {
			
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, fno);
			
			result = ps.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			close(ps);
		}
		
		return result;
	}

}


















