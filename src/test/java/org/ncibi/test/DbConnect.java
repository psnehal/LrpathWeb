package org.ncibi.test;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import org.rosuda.REngine.REXPMismatchException;

public class DbConnect {
	private static final String DB_DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	private static final String DB_CONNECTION = "jdbc:sqlserver://ncibidb.bicc.med.umich.edu:1433;databaseName=serverapps;selectMethod=cursor;schema=dbo";
	private static final String DB_USER = "userNcibiQueueService";
	private static final String DB_PASSWORD = "280010use9Service";
	

	public static void main(String[] args) throws IOException, REXPMismatchException, SQLException{	
		
		Connection dbConnection = null;
		Statement statement = null;
	
			String insertTableSQL = "select * from Task where uuid = '2846eb81-6a31-4499-a963-5c5bd3d0f8b2'";
			try {
				dbConnection = getDBConnection();
				statement = dbConnection.createStatement();
		
				System.out.println(insertTableSQL);		
				// execute insert SQL stetement
				ResultSet rs = statement.executeQuery(insertTableSQL);
		
				System.out.println(rs.getString("status"));
		
			} catch (SQLException e) {
		
				System.out.println(e.getMessage());
		
			} finally {
		
				if (statement != null) {
					statement.close();
				}

				if (dbConnection != null) {
					dbConnection.close();
				}
			}
}
			
			private static Connection getDBConnection() {
				 
				Connection dbConnection = null;
		 
				try {
		 
					Class.forName(DB_DRIVER);
		 
				} catch (ClassNotFoundException e) {
		 
					System.out.println(e.getMessage());
		 
				}
		 
				try {
		 
					dbConnection = DriverManager.getConnection(
		                               DB_CONNECTION, DB_USER,DB_PASSWORD);
					return dbConnection;
		 
				} catch (SQLException e) {
		 
					System.out.println(e.getMessage());
		 
				}
		 
				return dbConnection;
		 
			}
		 
}