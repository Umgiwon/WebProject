package com.kh.jsp.member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.jsp.member.model.service.MemberService;
import com.kh.jsp.member.model.vo.Member;

/**
 * Servlet implementation class MemberInsert
 */
@WebServlet("/insert.me")
public class MemberInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberInsert() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		String userId = request.getParameter("userId");
		String userPwd = request.getParameter("userPwd");
		String userName = request.getParameter("userName");
		String gender = request.getParameter("gender");
		int age = Integer.parseInt(request.getParameter("age"));
		String email = request.getParameter("email");
		// String phone = request.getParameter("phone");
		// String address = request.getParameter("address");
		
		String hobby = String.join(", ", request.getParameterValues("hobby"));
		// 010-1234-5678
		String phone = request.getParameter("tel1") + "-"
				     + request.getParameter("tel2") + "-"
				     + request.getParameter("tel3");
		
		String address = request.getParameter("zipCode") + ", "
					   + request.getParameter("address1") + ", "
					   + request.getParameter("address2");
		
		Member m = new Member(userId, userPwd, userName, gender, age, email, phone, address, hobby, null);
		
		MemberService service = new MemberService();
		
		int result = service.insertMember(m);
		
		if(result > 0 ) {
			
			// 회원 가입 성공
			response.sendRedirect("index.jsp");
		} else {
			
			// 회원 가입 실패
			RequestDispatcher view = request.getRequestDispatcher("views/common/errorPage.jsp");
			
			request.setAttribute("error-msg", "회원 가입 실패");
			
			view.forward(request, response);
		}
		
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
