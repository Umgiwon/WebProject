package com.kh.jsp.member.model.service;

import java.sql.Connection;

import com.kh.jsp.member.model.dao.MemberDAO;
import com.kh.jsp.member.model.vo.Member;

import static com.kh.jsp.common.JDBCTemplate.*;

public class MemberService {

//	private Connection con = null;
	private Connection con;
	private MemberDAO dao = new MemberDAO();
	
	public int insertMember(Member m) {
		con = getConnection();
		
		int result = dao.insertMember(con, m);
		
		if(result > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		
		close(con);
		
		return result;
	}

	public Member selectMember(Member loginMember) {
		con = getConnection();

		Member result = dao.selectMember(con, loginMember);

		close(con);

		return result;
	}

	public int updateMember(Member m) {
		con = getConnection();
		
		
		
		int result = dao.updateMember(con, m);
		
		if(result > 0) commit(con);
		else rollback(con);
		
		close(con);
		
		return result;
	}

	public int deleteMember(String userId) {
		con = getConnection();
		
		int result = dao.deleteMember(con, userId);
		
		if(result > 0) commit(con);
		else rollback(con);
		
		close(con);
		
		return result;
	}
	
	
	
	
	
	
	
	
}
