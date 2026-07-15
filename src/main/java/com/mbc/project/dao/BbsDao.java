package com.mbc.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mbc.project.database.DBClose;
import com.mbc.project.database.DBConnection;
import com.mbc.project.dto.BbsDto;

public class BbsDao {
	
	private static BbsDao dao= new BbsDao();
	
	public BbsDao() {		
	}
	
	public static BbsDao getInstance() {
		return dao;
	}
	
	public List<BbsDto> getBbsList() {
		
		String sql= " select seq,id,ref, step, depth,"
				+ "     title, content, wdate,"
				+ "     del, readcount "
				+ "     from bbs"
				+ "     order by ref desc, step asc";
		
		Connection conn=null;
		PreparedStatement psnt=null;
		ResultSet rs=null;
		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("getBbsList 1/3 success");
			
			psnt=conn.prepareStatement(sql);
			System.out.println("getBbsList 2/3 success");
			
			rs=psnt.executeQuery();
			
			while(rs.next()) {
				int seq =  rs.getInt("seq");
				String id = rs.getString("id");
				int ref = rs.getInt("ref");
				int step = rs.getInt("step");
				int depth = rs.getInt("depth");
				String title =rs.getString("title");
				String content = rs.getString("content");
				String wdate = rs.getString("wdate");
				int del =rs.getInt("del");
				int readcount = rs.getInt("readcount");
				
				BbsDto dto= new BbsDto(seq, id, ref, step, depth, title, content, wdate, del, readcount);
				
				list.add(dto);							
			}
			System.out.println("getBbsList 3/3 success");
		} catch (SQLException e) {
			System.out.println("getBbsList fail..");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psnt, rs);
		}
		return list;
	}
	
	public boolean bbswrite(BbsDto dto) {
	   
	    String sql = "   insert into bbs(id, ref, step, depth, title, content, wdate, del, readcount)" 
	    		+ "      values (?,(select coalesce(max(ref),0)+1 from bbs), 0, 0, ?, ?, now(), 0, 0)";
	    
	    Connection conn = null;
	    PreparedStatement psnt = null;
	    
	    try {
	       
	        conn = DBConnection.getConnection();
	        System.out.println("bbswrite 1/3 success");
	        
	        psnt = conn.prepareStatement(sql);
	        System.out.println("bbswrite 2/3 success");
	        
	        psnt.setString(1, dto.getId());
	        psnt.setString(2, dto.getTitle());
	        psnt.setString(3, dto.getContent());	        

	        int count = psnt.executeUpdate();
	        
	        if (count > 0) {
	        	System.out.println("bbswrite 3/3 success");
	            return true;
	        } else {
	            return false;
	        }
	        
	        
	    } catch (SQLException e) {
	    	System.out.println("bbswrite fail..");
	        e.printStackTrace();
	        return false;
	    } finally {
	        
	        DBClose.close(conn, psnt, null);
	    }
	}
	
	//글의 총수
	public int getAllBbs(String category, String keyword) {
		
		String sql=" select count(*) from bbs ";
		
		if(category.equals("title")) {
			sql +=" where title like '%"+keyword+"%' ";
			
		}else if(category.equals("content")) {
			sql +=" where content like '%"+keyword+"%' ";
		}else if(category.equals("writer")) {
			sql +=" where id = '"+keyword+"' ";
		}
		
		Connection conn=null;
		PreparedStatement psnt= null;
		ResultSet rs=null;
		
		int count = 0;
		

		try {
			conn=DBConnection.getConnection();
			
			psnt=conn.prepareStatement(sql);
			
			rs=psnt.executeQuery();
			if(rs.next()) {
				count =rs.getInt(1);
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psnt, rs);
		}
		
		return count;
	}
	
	
public List<BbsDto> getBbsList(String category, String keyword) {
		
		String sql= " select seq,id,ref, step, depth,"
				+ "     title, content, wdate,"
				+ "     del, readcount "
				+ "     from bbs";
		//검색
			if(category.equals("title")) {
				sql +=" where title like '%"+keyword+"%' ";
				
			}else if(category.equals("content")) {
				sql +=" where content like '%"+keyword+"%' ";
			}else if(category.equals("writer")) {
				sql +=" where id = '"+keyword+"' ";
			}
		
			sql +="     order by ref desc, step asc";
		
		Connection conn=null;
		PreparedStatement psnt=null;
		ResultSet rs=null;
		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("getBbsList 1/3 success");
			
			psnt=conn.prepareStatement(sql);
			System.out.println("getBbsList 2/3 success");
			
			rs=psnt.executeQuery();
			
			while(rs.next()) {
				int seq =  rs.getInt("seq");
				String id = rs.getString("id");
				int ref = rs.getInt("ref");
				int step = rs.getInt("step");
				int depth = rs.getInt("depth");
				String title =rs.getString("title");
				String content = rs.getString("content");
				String wdate = rs.getString("wdate");
				int del =rs.getInt("del");
				int readcount = rs.getInt("readcount");
				
				BbsDto dto= new BbsDto(seq, id, ref, step, depth, title, content, wdate, del, readcount);
				
				list.add(dto);							
			}
			System.out.println("getBbsList 3/3 success");
		} catch (SQLException e) {
			System.out.println("getBbsList fail..");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psnt, rs);
		}
		return list;
	}
	
public List<BbsDto> getBbsList(String category, String keyword, int pageNumber) {
	
	String sql= " select seq,id,ref, step, depth,"
			+ "     title, content, wdate,"
			+ "     del, readcount "
			+ "     from bbs";
	//검색
		if(category.equals("title")) {
			sql +=" where title like '%"+keyword+"%' ";
			
		}else if(category.equals("content")) {
			sql +=" where content like '%"+keyword+"%' ";
		}else if(category.equals("writer")) {
			sql +=" where id = '"+keyword+"' ";
		}
	
		sql +="     order by ref desc, step asc";
		
		//paging
		sql += "   limit 10 offset "+ (pageNumber * 10);
	
	Connection conn=null;
	PreparedStatement psnt=null;
	ResultSet rs=null;
	
	List<BbsDto> list = new ArrayList<BbsDto>();
	
	
	
	try {
		conn = DBConnection.getConnection();
		System.out.println("getBbsList 1/3 success");
		
		psnt=conn.prepareStatement(sql);
		System.out.println("getBbsList 2/3 success");
		
		rs=psnt.executeQuery();
		
		while(rs.next()) {
			int seq =  rs.getInt("seq");
			String id = rs.getString("id");
			int ref = rs.getInt("ref");
			int step = rs.getInt("step");
			int depth = rs.getInt("depth");
			String title =rs.getString("title");
			String content = rs.getString("content");
			String wdate = rs.getString("wdate");
			int del =rs.getInt("del");
			int readcount = rs.getInt("readcount");
			
			BbsDto dto= new BbsDto(seq, id, ref, step, depth, title, content, wdate, del, readcount);
			
			list.add(dto);							
		}
		System.out.println("getBbsList 3/3 success");
	} catch (SQLException e) {
		System.out.println("getBbsList fail..");
		e.printStackTrace();
	}finally {
		DBClose.close(conn, psnt, rs);
	}
	return list;
}


public List<BbsDto> getBbsList(int seq) {
    String sql = " SELECT seq, id, ref, step, depth, title, content, wdate, del, readcount " +
                 " FROM bbs WHERE seq = ? "; 
    
    Connection conn = null;
    PreparedStatement psnt = null;
    ResultSet rs = null;
    List<BbsDto> list = new ArrayList<BbsDto>(); 
    
    try {
        conn = DBConnection.getConnection();
        System.out.println("getBbsList-seq 1/3 success");
        
        psnt = conn.prepareStatement(sql);
        System.out.println("getBbsList-seq 2/3 success");
        
        psnt.setInt(1, seq); 
        rs = psnt.executeQuery();
        
        while(rs.next()) {
            BbsDto dto = new BbsDto(
                rs.getInt("seq"), rs.getString("id"), rs.getInt("ref"),
                rs.getInt("step"), rs.getInt("depth"), rs.getString("title"),
                rs.getString("content"), rs.getString("wdate"), 
                rs.getInt("del"), rs.getInt("readcount")
            );
            list.add(dto); 
        }
        System.out.println("getBbsList-seq 3/3 success");
    } catch (SQLException e) {
    	System.out.println("getBbsList-seq fail..");
        e.printStackTrace();
    } finally {
        DBClose.close(conn, psnt, rs);
    }
    return list; 
}

	public void readcount(int seq) {
		String sql = " UPDATE bbs SET readcount = readcount + 1 WHERE seq = ? ";
	    
	    Connection conn = null;
	    PreparedStatement psnt = null;
	    
	    try {
	        conn = DBConnection.getConnection();
	        System.out.println("readcount 1/3 success");
	        
	        psnt = conn.prepareStatement(sql);
	        System.out.println("readcount 2/3 success");
	        
	        psnt.setInt(1, seq);
	        psnt.executeUpdate();
	        System.out.println("readcount 3/3 success");
	    } catch (SQLException e) {
	    	System.out.println("readcount fail...");
	        e.printStackTrace();
	    } finally {
	        DBClose.close(conn, psnt, null);
	        
	    	}
	}

	public void answerUpdate(int seq) {
		String sql =" update bbs "
				+"    set step=step+1 "
				+ "  where ref = (select ref from bbs where seq=?) "
				+"   and step > (select step from bbs where seq=?) ";
		
		Connection conn=null;
		PreparedStatement psnt=null;
		
		try {
			
			conn = DBConnection.getConnection();
			System.out.println("answerUpdate 1/6success");
			
			
			psnt=conn.prepareStatement(sql);			
			psnt.setInt(1, seq);
			psnt.setInt(2, seq);
			System.out.println("answerUpdate 2/6success");
			
			psnt.executeUpdate();
			System.out.println("answerUpdate 3/6success");
			
		} catch (SQLException e) {
			System.out.println("answerUpdate fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psnt, null);
		}
		
	}

	public boolean answerInsert(int seq, BbsDto bbs) {
		String sql = " insert into bbs(id, ref, step, depth, "
				+ "            title, content, wdate, del, readcount) "
				+ "  values(?, (select ref from bbs where seq=?), "
				+ "       (select step from bbs where seq=?)+1, "
				+ "       (select depth from bbs where seq=?)+1, "
				+ "       ?, ?, now(), 0, 0) ";
		
		Connection conn=null;
		PreparedStatement psnt=null;
		
		int count=0;
		
		
		try {
			conn=DBConnection.getConnection();
			System.out.println("answerUpdate 4/6success");
			psnt=conn.prepareStatement(sql);
			
			psnt.setString(1, bbs.getId());
			psnt.setInt(2, seq);
			psnt.setInt(3, seq);
			psnt.setInt(4, seq);
			psnt.setString(5, bbs.getTitle());
			psnt.setString(6, bbs.getContent());
			System.out.println("answerUpdate 5/6success");
			
			count=psnt.executeUpdate();
			System.out.println("answerUpdate 6/6success");
			
		} catch (SQLException e) {
			System.out.println("answerUpdate fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psnt, null);
		}
		
		return count>0?true:false;
		
	}

	public boolean Updatebbs(int seq, String title, String content) {
		
		String sql = " UPDATE bbs SET title = ?, content = ?, wdate = CURRENT_TIMESTAMP WHERE seq = ? ";
	    
	    Connection conn = null;
	    PreparedStatement psnt = null;
	    int count = 0; 
	    
	    try {
	        conn = DBConnection.getConnection();
	        System.out.println("Updatebbs 1/3success");
	        
	        psnt = conn.prepareStatement(sql);
	        
	        psnt.setString(1, title);
	        psnt.setString(2, content);
	        psnt.setInt(3, seq);
	        System.out.println("Updatebbs 2/3success");
	        
	        count = psnt.executeUpdate();
	        System.out.println("Updatebbs 3/3success");
	        
	    } catch (SQLException e) {
	        System.out.println("Updatebbs Fail...");
	        e.printStackTrace();
	    } finally {
	        DBClose.close(conn, psnt, null);
	    }
	    
	    return count>0?true:false;
	}
	
	public boolean deletebbs(int seq) {
		String sql = " DELETE FROM bbs WHERE seq = ? ";
		
	    Connection conn = null;
	    System.out.println("deletebbs 1/3success");
	    
	    PreparedStatement psnt = null;
	    int count = 0;
	    
	    try {
	        conn = DBConnection.getConnection();
	        psnt = conn.prepareStatement(sql);
	        psnt.setInt(1, seq);
	        System.out.println("deletebbs 2/3success");
	        
	        count = psnt.executeUpdate();
	        System.out.println("deletebbs 3/3success");
	        
	    } catch (SQLException e) {
	    	System.out.println("deletebbs Fail....");
	        e.printStackTrace();
	    } finally {
	        DBClose.close(conn, psnt, null);
	    }
	    return count>0?true:false;
	}

}
