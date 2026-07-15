package com.mbc.project.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

// 언제든 호출
public class DBConnection {

	public static void initConnection() {
		try {
			Class.forName("org.postgresql.Driver");
			
			System.out.println("Driver Loading Success");
		} catch (ClassNotFoundException e) {			
			System.out.println("Driver Loading fail~");
		}
	}
	
	public static Connection getConnection() {
		Connection conn = null;		
		try {
			conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres?useUnicode=true&characterEncoding=UTF-8", "postgres", "1234");
			
			System.out.println("PostgreSQL Connection Success");
		} catch (SQLException e) {			
			e.printStackTrace();
		}		
		return conn;
	}
}


