package it.offers.dao;

import it.offers.db.Database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map.Entry;

import org.apache.tomcat.util.codec.binary.StringUtils;

public class OffersImplDao implements OffersDao{

	public int insert(String tableName,HashMap<String,Object> map){
			int status=0;
			StringBuilder sqlBuilder = new StringBuilder();
			sqlBuilder.append("INSERT INTO "+tableName+" ( ");	
			String camp = "";
			String val = "";
			for(Entry<String, Object> entry:map.entrySet()){
					camp+= entry.getKey()+",";
					val+= entry.getValue()==null? entry.getValue()+"," : (isNumeric(entry.getValue().toString()) ? entry.getValue(): "'"+entry.getValue().toString()+"'")+",";	
			}
			camp =camp.substring(0, camp.length()-1);
			val =val.substring(0, val.length()-1);
			
			camp+=") values ("+ val +" )";
			
			sqlBuilder.append(camp);
			
			String sql = sqlBuilder.toString();
			System.out.println("insert query:"+sql+";");
			Connection con;
			Statement st;
			try {
				con = Database.getConnection();
				st = con.createStatement();
				status = st.executeUpdate(sql);
			} catch (SQLException 
					| InstantiationException 
					| IllegalAccessException 
					| ClassNotFoundException e) {
				
				e.printStackTrace();
			}
			
		return status;
	}

	public int delete(String tableName,HashMap<String,Object> cond){
		int status =0;
		if(cond!=null && cond.size()==0)
			return status;
		try {
			StringBuilder sqlBuilder = new StringBuilder();
			sqlBuilder.append("DELETE FROM "+tableName);	
			for(Entry<String, Object> entry:cond.entrySet()){	
				sqlBuilder.append(" WHERE "+entry.getKey()+"="+entry.getValue());	
			}
			String sql = sqlBuilder.toString();
			Connection con;
			try {
				con = Database.getConnection();
				Statement st = con.createStatement();
				status=st.executeUpdate(sql);
			} catch (InstantiationException 
					| IllegalAccessException
					| ClassNotFoundException e) {
				e.printStackTrace();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return status;
	}
	public ResultSet get(String tableName,HashMap<String,Object> map){
		ResultSet rs=null;
		try {
			StringBuilder sqlBuilder = new StringBuilder();
			sqlBuilder.append("SELECT * FROM "+tableName);	
			sqlBuilder.append(" WHERE 1=1 ");
			if(map!=null){
				for(Entry<String, Object> entry:map.entrySet()){	
					sqlBuilder.append(" AND "+entry.getKey()+"="+entry.getValue());	
				}
			}
			String sql = sqlBuilder.toString();
			System.out.println("::::::::::sql=="+sql);
			Connection con = Database.getConnection();
			System.out.println(":::::::::::::::Connection:::::"+con);
			Statement st = con.createStatement();
			System.out.println("st===="+st);
			rs = st.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}
	
	public static boolean isNumeric(String str)
	{
	    for (char c : str.toCharArray())
	    {
	        if ('.'!= c && !Character.isDigit(c)) return false;
	    }
	    return true;
	}
	
}
