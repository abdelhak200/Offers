<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
</head>

<title>RestFul</title>

<style>

</style>
</head>
<body>
<h1>Products</h1>

<br/><br/>
<table id="empData" width="750px" cellpadding="1" border="1">
</table>
<script>
jQuery(document).ready(function(){
	$.ajax({
	    url: "http://localhost:8080/Offers/rest/all",
	    type:"GET",
	    contentType: "application/json; charset=utf-8",
	    success: function(data) {
	    	
	    if(data!=null){
	    		var html = "<tr><td>ID</td><th>Name</td><td>Category</td><td>Price</td><td>Validation</td></tr>";
	    		$.each(data, function(i, offer) {
	    		  //use obj.id and obj.name here, for example:
	    		  alert(offer.eDate);
	    		   html += "<tr id='row_"+offer.id+"'><td>"+offer.id+"</td><td>"+offer.name+"</td><td>"+offer.category+"</td><td>"+offer.price+"</td>";
	    		   html += "<td><a href='javascript:void(0);' onclick='deleteOffer("+offer.id+")'>'validate("+offer.eDate+")'</a></td>";
	    		 
	    		});
	    		$("#empData").append(html);
	    }	
	    	
	    },
	    error: function(data) {}
	});
	$("#frmAdd").submit(function(){
		$.ajax({
		    url: "http://localhost:8080/Offers/rest/add",
		    type:"POST",
		    contentType: "application/json; charset=utf-8",
		    dataType: 'json',
		    data:formToJSON(),
		    statusCode : {
                200 : function(jqXHR) {
					 var html="";
  			    	 html += "<tr><td>"+$('#id').val()+"</td><td>"+$('#name').val()+"</td><td>"+$('#category').val()+"</td><td>"+$('#price').val()+"</td>";
  		    		 html += "<td><a href='javascript:void(0);' onclick='deleteOffer("+$('#id').val()+")'>'validate("+offer.eDate+")'</a></td>";
  					$("#empData").append(html);
  					$("#id").val("");
  					$("#name").val("");
  					$("#category").val("");
  					$("#price").val("");
  					$("#eDate").val("");

                },
		     400:function(jqXHR){
		    	 
		    	  alert("Please provide valid data");
		     }

            },
		});
		return false;
	});		
});

 function formToJSON() {
    var str= JSON.stringify({
    	"id": $('#id').val(),
        "name": $('#name').val(),
        "category": $('#category').val(),
        "price": $('#price').val(),
        "eDate": $('#eDate').val()
        });
    return str;
}
 function deleteOffer(id){
	$.ajax({
		    url: "http://localhost:8080/Offers/rest/"+id,
		    type:"DELETE",
		    statusCode : {
	            200 : function(jqXHR) {
	   			  	    $("#row_"+id).remove();	
	                },
			     400:function(jqXHR){
			    	  alert("Please provide valid data");
			     }
		    }
	}); 
 }
 
 $( function() {
   $( "#datepicker" ).datepicker();
 } );

 function validate(expireDate){
	 var acttualDate= new Date();
	 alert(expireDate);
	 alert(acttualDate);
		if( expireDate != null && expireDate>=acttualDate)
			return "delete".css( "color", "red" );
		else
			return "valid".css( "color", "blu" );
	 }
 
</script>
<br/><br/><br/><br/>

<form action="" id="frmAdd" method="post">
<h2>Add Offer</h2>
<table width="750px">
<tr>
	<td>Name</td>
 	<td><input type="text" name="name" id="name"></td>
</tr>
<tr>
	<td>Category</td>
 	<td><input type="text" name="category" id="category"></td>
</tr>
<tr>
	<td>Price</td>
 	<td><input type="text" name="price" id="price"></td>
</tr>
<tr>
	<td>Expire Date</td>
 	<td><input type="text" name="eDate" id="datepicker"></td>
</tr>
<tr>
	<td></td>
 	<td><input type="submit" name="add" value="Add Offer"></td>
</tr>
</table>
</form>
</body>
</html>

