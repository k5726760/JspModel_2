package com.mbc.project.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;

import com.mbc.project.dao.BbsDao;
import com.mbc.project.dto.BbsDto;
import com.mbc.project.dto.MemberDto;

@WebServlet("/bbs")
public class BbsController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProc(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProc(req,resp);
	}

	public void doProc(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			req.setCharacterEncoding("UTF-8");
		
			String param=req.getParameter("param");
			BbsDao dao = BbsDao.getInstance();
			
			if(param.equals("bbslist")) {
				//카테고리 & 검색어 
				String category=req.getParameter("category");
				String keyword=req.getParameter("keyword");
				if(category==null) {
					category="title";
				}
				if(keyword==null) {
					keyword="";
				}
				
				//page number
				String sPageNumber=req.getParameter("pageNumber");
				int pageNumber=0;
				
				//parameter로 넘어 온 값이 있을 때
				if(sPageNumber!=null && !sPageNumber.equals("")) {
					pageNumber=Integer.parseInt(sPageNumber);
				}
				
				//글목록
				List<BbsDto> list=dao.getBbsList(category, keyword, pageNumber);
				
				//글의 총 수
				int count=dao.getAllBbs(category, keyword);
				
				//페이지 계산
				int pageBbs = count/10;
				if((count%10)>0) {
					pageBbs += 1;
				}
				
				//짐싸!
				req.setAttribute("list", list);          //글목록
				req.setAttribute("pageBbs", pageBbs);     //페이지 총수
				req.setAttribute("pageNumber", pageNumber);  //현재 페이지
				req.setAttribute("category", category);      //카테고리
				req.setAttribute("keyword", keyword);
				
				//잘가~
				forward("bbslist.jsp", req, resp);
			} 
			
			else if(param.equals("bbswrite")) {  //글쓰기
				
				MemberDto login=(MemberDto)req.getSession().getAttribute("login");
							
				if(login == null) {
				    req.setAttribute("write", "LOGIN_REQUIRED"); 
				    forward("message.jsp", req, resp);
				} else {
					req.setAttribute("id", login.getId());
				    forward("bbswrite.jsp", req, resp); // 로그인 시 글쓰기 페이지로 이동
				}								
			}
			
			else if(param.equals("bbswriteAf")) {				
								
				String id = req.getParameter("id");
				String title = req.getParameter("title");
				String content = req.getParameter("content");
				
				boolean isS=dao.bbswrite(new BbsDto(id, title, content));
				
				String bbsWriteMsg ="BBSWRITE_SUCCESS";
				if(!isS) {
					bbsWriteMsg ="BBSWRITE_FAIL";
				}
				req.setAttribute("bbsWriteMsg", bbsWriteMsg);
				forward("message.jsp", req, resp);		
			}
			
			else if(param.equals("bbsdetail")) {
				int seq=Integer.parseInt(req.getParameter("seq"));
				
				//조회수 증가
				dao.readcount(seq);
				
				//dto
				BbsDto dto = dao.getBbsList(seq).get(0);
				
				//짐싸!
				req.setAttribute("dto", dto);
				
				//잘가~
				forward("bbsdetail.jsp", req, resp);
			}
			
			else if(param.equals("bbsanswer")) {
				
				int seq=Integer.parseInt(req.getParameter("seq"));			
				List<BbsDto> list = dao.getBbsList(seq);

				BbsDto dto = null;
				if (list != null && list.size() > 0) {
				    dto = list.get(0); // 데이터가 있을 때만 담음
				}
				
				req.setAttribute("dto", dto);
				
				forward("bbsanswer.jsp", req, resp);
			}
			
			else if(param.equals("bbsanswerAf")) {
				int seq=Integer.parseInt(req.getParameter("seq"));
				 
			 	String id=req.getParameter("id");
			 	String title=req.getParameter("title");
			 	String content=req.getParameter("content");
			 	
			 	dao.answerUpdate(seq);
			 	
			 	boolean isS = dao.answerInsert(seq, new BbsDto(id, title, content));

			 	String bbsAnsMsg ="";
			    if(isS) {
			        req.setAttribute("bbsAnsMsg", "BBSANSMSG_SUCCESS");
			        req.setAttribute("url", "bbs?param=bbslist"); 
			    } else {
			        req.setAttribute("bbsAnsMsg", "BBSANSMSG_FAIL");
			        req.setAttribute("url", "bbs?bbsanswer&seq=" + seq);
			    }
			    forward("message.jsp", req, resp); 		 	
			}
			
			else if(param.equals("bbsupdate")) {
				int seq=Integer.parseInt(req.getParameter("seq"));

				List<BbsDto> list = dao.getBbsList(seq);

				BbsDto dto = null;
				if (list != null && list.size() > 0) {
				    dto = list.get(0); // 데이터가 있을 때만 담음
				}
				
				req.setAttribute("dto", dto);				
				forward("bbsupdate.jsp", req, resp);
				
			}
			
			else if(param.equals("bbsupdateAf")) {
				int seq = Integer.parseInt(req.getParameter("seq"));
			    String title = req.getParameter("title");
			    String content = req.getParameter("content");

			    // DAO를 사용하여 업데이트 수행
			    boolean isS = dao.Updatebbs(seq, title, content);

			    if (isS) {
			        req.setAttribute("bbsUpdateMsg", "BBSUPDATE_SUCCESS");
			        req.setAttribute("url", "bbs?param=bbslist");
			    } else {
			        req.setAttribute("bbsUpdateMsg", "BBSUPDATE_FAIL");
			        req.setAttribute("url", "bbs?param=bbsupdate&seq=" + seq);
			    }
			    forward("message.jsp", req, resp);
			}
			
			else if(param.equals("bbsdeleteAf")) {
				int seq = Integer.parseInt(req.getParameter("seq"));		    
			    boolean isS = dao.deletebbs(seq);
				
			    if (isS) {
			        req.setAttribute("bbsDeleteMsg", "BBSDELETE_SUCCESS");
			        req.setAttribute("url", "bbs?param=bbslist");
			    } else {
			        req.setAttribute("bbsDeleteMsg", "BBSDELETE_FAIL");
			        req.setAttribute("url", "bbs?param=bbsdetail&seq=" + seq);
			    }
			    forward("message.jsp", req, resp);
			    
			}
			
	}
	
	public void forward(String url,HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher rd=req.getRequestDispatcher(url);
		rd.forward(req, resp);
	}
	
	
	
}
