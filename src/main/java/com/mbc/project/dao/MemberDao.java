package com.mbc.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mbc.project.database.DBClose;
import com.mbc.project.database.DBConnection;
import com.mbc.project.dto.MemberDto;

public class MemberDao {

	private static MemberDao dao = null;
	
	private MemberDao() {
		DBConnection.initConnection();
	}
	
	public static MemberDao getInstance() {
		if(dao == null) {
			dao = new MemberDao();
		}
		return dao;
	}
	
	public int idcheck(String id) {
		String sql = " 	select count(*) "
				+ "		from member "
				+ "		where id = ? ";
		
		Connection conn = null;		// 연결
		PreparedStatement psmt = null;	// 쿼리실행
		ResultSet rs = null;		// 결과
		
		int count = 0;	// return 값
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("idcheck 1/3 success");
				
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("idcheck 2/3 success");
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);				
			}			
			System.out.println("idcheck 3/3 success");
			
		} catch (SQLException e) {
			System.out.println("idcheck fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);			
		}
		
		return count;
	}
	
	public boolean addMember(MemberDto mem) {
		
		String sql = " 	insert into member(id, pw, name, email, auth) "
				+ "		values(?, ?, ?, ?, 3) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("addMember 1/3 success");
				
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, mem.getId());
			psmt.setString(2, mem.getPw());
			psmt.setString(3, mem.getName());
			psmt.setString(4, mem.getEmail());
			System.out.println("addMember 2/3 success");
			
			count = psmt.executeUpdate();
			System.out.println("addMember 3/3 success");
			
		} catch (SQLException e) {
			System.out.println("addMember fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
	
		return count>0?true:false;
	}
	
	public MemberDto login(MemberDto mem) {
		
		String sql = " 	select id, name, email, auth "
				+ "		from member "
				+ "		where id = ? and pw = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MemberDto dto = null;
				
		try {
			conn = DBConnection.getConnection();
			System.out.println("login 1/3 success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, mem.getId());
			psmt.setString(2, mem.getPw());
			System.out.println("login 2/3 success");
			
			rs = psmt.executeQuery();
			if(rs.next()) {				
				String id = rs.getString(1);
				String name = rs.getString(2);
				String email = rs.getString(3);
				int auth = rs.getInt(4);
				
				dto = new MemberDto(id, null, name, email, auth);
			}	
			System.out.println("login 3/3 success");
			
		} catch (SQLException e) {
			System.out.println("login fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return dto;
	}	
	
	
}




