package it.offers.contoller;

import it.offers.bean.Offer;
import it.offers.dao.OffersImplDao;
import it.offers.db.Database;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.google.gson.Gson;
 
@Path("/")
public class OffersController {
	
	 @GET  
	 @Path("/all")
	 @Produces(MediaType.APPLICATION_JSON)
	  public String getAllOffers(){
		 OffersImplDao dao = new OffersImplDao();
		 Gson gson = new Gson();
		 List<Offer> list = new ArrayList<Offer>();
		 ResultSet rs = dao.get("offer", null);
		 if(rs!=null){
			  try {
				while(rs.next()){
					 Offer o = new Offer();
					 o.setId(rs.getInt("id")); 
					 o.setName(rs.getString("name")); 
					 o.setCategory(rs.getString("category"));
					 o.setPrice(rs.getDouble("price"));
					 o.seteDate(rs.getString("eDate"));
					 list.add(o);
				  }
				
			} catch (SQLException ox) {
				ox.printStackTrace();
			} finally{
				 Database.close();
			 }
		  }
		
		  return gson.toJson(list);
	  }	
	  @GET  
	  @Path("/{name}")
	  @Produces(MediaType.APPLICATION_JSON)
	  public String getOfferById(@PathParam("name") int name) {  
		  Gson gson = new Gson();
		  OffersImplDao dao = new OffersImplDao();
		  Offer o = new Offer();
		  HashMap<String, Object> map = new HashMap<String, Object>();
		  map.put("name", name);
		  ResultSet rs = dao.get("offer", map);
		  if(rs!=null){
			  try {
				while(rs.next()){
					 o.setId(rs.getInt("id")); 
					 o.setName(rs.getString("name")); 
					 o.setCategory(rs.getString("category"));
					 o.setPrice(rs.getDouble("price"));
					 o.seteDate(rs.getString("eDate"));
				  }
			} catch (SQLException ox) {
				ox.printStackTrace();
			} finally{
				 Database.close();
			 }
		  }
		  return gson.toJson(o);
		  //return o;	  
	  }  
	  @GET  
	  @Path("/{id}")
	  @Produces(MediaType.APPLICATION_XML)
	  public Offer getOfferByIdInXML(@PathParam("id") int id) {  
		  Gson gson = new Gson();
		  OffersImplDao dao = new OffersImplDao();
		  Offer o = new Offer();
		  HashMap<String, Object> map = new HashMap<String, Object>();
		  map.put("id", id);
		  ResultSet rs = dao.get("offer", map);
		  if(rs!=null){
			  try {
				while(rs.next()){
					 o.setId(rs.getInt("id")); 
					 o.setName(rs.getString("name")); 
					 o.setCategory(rs.getString("category"));
					 o.setPrice(rs.getDouble("price"));
					 o.seteDate(rs.getString("eDate"));
				  }
			} catch (SQLException ox) {
				ox.printStackTrace();
			} finally{
				 Database.close();
			 }
		  }
		  //return gson.toJson(e);
		  return o;	  
	  }  
	  @POST
	  @Path("/add")
	  @Consumes({MediaType.APPLICATION_JSON})
	  @Produces({ MediaType.APPLICATION_JSON})
	  public Response addOffer(String OffJson) {
		 Gson gson = new Gson();
		 Offer Off = gson.fromJson(OffJson, Offer.class);
		 OffersImplDao dao = new OffersImplDao(); 
		 Response r = null;
		 HashMap<String, Object> map = new HashMap<String, Object>();
		 
		 map.put("name", Off.getName());
		 map.put("category",Off.getCategory());
		 map.put("price",Off.getPrice());
		 map.put("eDate",Off.geteDate());
		 
		dao.insert("offer", map);
		r =  Response.status(Response.Status.OK).entity("Successfully Created").build();
		 return r;
	  } 
	  
	  @DELETE
	  @Path("/{id}")
	  @Produces({ MediaType.APPLICATION_JSON})
	  public Response deleteOffer(@PathParam("id") int id){
		  
		Response r = null;
		 OffersImplDao dao = new OffersImplDao(); 
		 if(id!=0){
			 HashMap<String, Object> map = new HashMap<String, Object>();
			 map.put("id", id);
			 dao.delete("offer", map);
			 r =  Response.status(Response.Status.OK).entity("Successfully deleted").build();
			 
		 }else{
			 
			 r= Response.status(Response.Status.BAD_REQUEST).entity("Please provide Offer id").build();
		 }
		 return r;
	  }
	
}
