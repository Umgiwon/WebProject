package com.kh.jsp.member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.jsp.member.model.service.MemberService;
import com.kh.jsp.member.model.vo.Member;

/**
 * Servlet implementation class MemberUpdate
 */
@WebServlet("/update.me")
public class MemberUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberUpdate() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String userPwd = request.getParameter("userPwd");
		int age = Integer.parseInt(request.getParameter("age"));
		String email = request.getParameter("email");
		String phone = request.getParameter("tel1") + "-"
				 + request.getParameter("tel2") + "-"
				 + request.getParameter("tel3");
	
		String address = request.getParameter("zipCode") + ", "
			     + request.getParameter("address1") + ", "
			     + request.getParameter("address2");
	
		String hobby = String.join(", ", request.getParameterValues("hobby"));
		
		// 해당 회원을 구분짓는 ID 받아오기
		HttpSession session = request.getSession(false);
		
		Member m = (Member)session.getAttribute("member");
		
		// 기존의 회원 정보를 새로운 값으로 변경하기
		m.setUserPwd(userPwd);
		m.setAge(age);
		m.setEmail(email);
		m.setPhone(phone);
		m.setAddress(address);
		m.setHobby(hobby);
		
		System.out.println("변경한 회원 정보 확인 : " + m);
		
		MemberService service = new MemberService();
		
		int result = service.updateMember(m);
		
		if(result > 0 ) {
			
//			session.setAttribute("member", m);
			session.invalidate();

			response.sendRedirect("index.jsp");
		} else {
			
			RequestDispatcher view = request.getRequestDispatcher("views/common/errorPage.jsp");
			
			request.setAttribute("error-msg", "회원 정보 수정 실패");
			
			view.forward(request, response);
		}
		
		
	}

}
