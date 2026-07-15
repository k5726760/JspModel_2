package com.mbc.project.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mbc.project.dao.MemberDao;
import com.mbc.project.dto.MemberDto;
import net.sf.json.JSONObject;

public class MemberController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProc(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProc(req, resp);
	}
	
	public void doProc(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
		//System.out.println("MemberController doProc");
		req.setCharacterEncoding("utf-8");
		
		String param=req.getParameter("param");
		MemberDao dao= MemberDao.getInstance();
		
		if(param.equals("login")) {
			resp.sendRedirect("loginB.jsp");
		}
		
		else if(param.equals("regi")) {
			resp.sendRedirect("regi.jsp");
		}
		
		else if(param.equals("idcheck")) {
			String id=req.getParameter("id");
			
			int count = dao.idcheck(id);
			
			String str = "YES";
			if(count>0) {
				str="NO";
			}
			
			JSONObject obj=new JSONObject();
			obj.put("str", str);  //<-짐싸!(데이터 이동 준비)
			
			resp.setContentType("application/x-json; charset=utf-8");
			resp.getWriter().print(obj); //<-잘가~ (데이터 이동)
			
		}
		
		else if(param.equals("regiAf")) {
			String id = req.getParameter("id");
			String pw = req.getParameter("pw");
			String name = req.getParameter("name");
			String email =  req.getParameter("email");
			
			
			boolean isS = dao.addMember(new MemberDto(id, pw, name, email, 0));
			String message="MEMBER_OK";
			if(!isS) {
				message="MEMBER_NG";
			}
			
			req.setAttribute("message", message); //짐싸!
			//req.getRequestDispatcher("message.jsp").forward(req, resp);
			forward("message.jsp", req, resp);  //잘가
		}
		
		else if(param.equals("loginAf")) {
			String id=req.getParameter("id");
			String pw=req.getParameter("pw");
			
			MemberDto dto = dao.login(new MemberDto(id, pw, null, null, 0));
			String login="";
			if (dto == null || dto.getId().equals("")) {
			    login = "FAIL";
			} else {
			    login = "SUCCESS";
			    req.getSession().setAttribute("login", dto); 
			}
			req.setAttribute("login", login); //짐싸!
			forward("message.jsp", req, resp);  //잘가
			
		}
		
	}
	
	
	public void forward(String url,HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher rd=req.getRequestDispatcher(url);
		rd.forward(req, resp);
	}
	

}
