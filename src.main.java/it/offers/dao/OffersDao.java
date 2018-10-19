package it.offers.dao;

import java.sql.ResultSet;
import java.util.HashMap;

public interface OffersDao {

	public int insert(String tableName,HashMap<String,Object> map);
	
	public int delete(String tableName,HashMap<String,Object> cond);
	
	public ResultSet get(String tableName,HashMap<String,Object> map);
}
