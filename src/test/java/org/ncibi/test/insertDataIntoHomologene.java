package org.ncibi.test;

	import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.ResourceBundle;
import java.sql.BatchUpdateException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Vector;

	import org.junit.Test;
import org.ncibi.commons.db.JDBCExecuter;
import org.rosuda.REngine.REXPMismatchException;

	public class insertDataIntoHomologene { 
		
		private static final String DB_DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		private static final String DB_CONNECTION = "jdbc:sqlserver://ncibidb3.bicc.med.umich.edu:1433;databaseName=conceptdata";
		private static final String DB_USER = "snehal2";
		private static final String DB_PASSWORD = "ncibi2014!!";
		private static final DateFormat dateFormat = new SimpleDateFormat(
				"yyyy/MM/dd HH:mm:ss");

		
		public static void main(String[] args) throws IOException, REXPMismatchException
		{	
			try {
				 
				insertRecordIntoDbUserTable();
	 
			} catch (SQLException e) {
	 
				System.out.println(e.getMessage());
	 
			}
			
			
			
		}
		
		private static void insertRecordIntoDbUserTable() throws SQLException {
			 
			Connection dbConnection = null;
			Statement statement = null;
			String csvFile = "/home/snehal/DataFiles/LRpath/ElementFinalCSV.csv";
			BufferedReader br = null;
			String line = "";
			String cvsSplitBy = ",";
					
					try {
						 
						br = new BufferedReader(new FileReader(csvFile));
						while ((line = br.readLine()) != null) {
				 
						        // use comma as separator
							String[] tokens = line.split(cvsSplitBy);
				 
							System.out.println("(" + tokens[0]+",'"+tokens[1]+"',"+tokens[2]+","+tokens[3]+")");
							String data = "(" + tokens[0]+",'"+tokens[1]+"',"+tokens[2]+",'"+tokens[3]+"');";
							String insertTableSQL = "insert into ELEMENT_2014 values"+data;
							try {
								dbConnection = getDBConnection();
								statement = dbConnection.createStatement();
					 
								System.out.println(insertTableSQL);
					 
								// execute insert SQL stetement
								statement.executeUpdate(insertTableSQL);
					 
								System.out.println("Record is inserted into DBUSER table!");
					 
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
						
					} catch (FileNotFoundException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					} finally {
						if (br != null) {
							try {
								br.close();
							} catch (IOException e) {
								e.printStackTrace();
							}
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
	 
		private static String getCurrentTimeStamp() {
	 
			java.util.Date today = new java.util.Date();
			return dateFormat.format(today.getTime());
	 
		}
	 
	}



