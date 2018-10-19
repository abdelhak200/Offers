package it.offers.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {
	
	private static String dbURL = "jdbc:derby:C:/Users/Windows 8/workspace/Offers/OfferDB;create=true;user=user;password=user";
	static Connection con =null;
	
	public static Connection getConnection() throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		try{  
			Class.forName("org.apache.derby.jdbc.EmbeddedDriver");   
			con=DriverManager.getConnection(dbURL);
			System.out.println(":::::::::::::::::::::con:::::::::::::"+con);
		}catch(Exception e){
			e.printStackTrace();
		}
		return con;
			
	}
	
	public static void close(){
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

//	 public static void main(String[] args) throws InstantiationException, IllegalAccessException, ClassNotFoundException {
//			try {
//				getConnection();
//				stmt = conn.createStatement();
//				ResultSet results = stmt.executeQuery("select * from offer");
//				
//				ResultSetMetaData rsmd = results.getMetaData();
//				int numberCols = rsmd.getColumnCount();
//				for (int i = 1; i <= numberCols; i++) {
//					// print Column Names
//					System.out.print(rsmd.getColumnLabel(i) + "\t\t");
//				}
//
//				System.out.println("\n----------------------------------------------------------------------------");
//
//				while (results.next()) {
//					int id = results.getInt(1);
//					String name = results.getString(2);
//					String type = results.getString(3);
//					double price = results.getDouble(4);
//					System.out.println(id + "\t\t" + name + "\t\t" + type + "\t\t\t" + price);
//				}
//				results.close();
//				stmt.close();
//			} catch (SQLException sqlExcept) {
//				sqlExcept.printStackTrace();
//			}
//		}
	
}
