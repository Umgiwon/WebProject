package com.kh.jsp.thumb.model.dao;

import java.io.*;
import java.sql.*;
import java.util.*;

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
				t.setBoardfile(	rs.getString("boardfile"));

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

}
