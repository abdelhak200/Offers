<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
</head>

<title>RestFul</title>

<style>
.search:hover button {
  display: inline-block;
}
.search {
  background: white;
  display: inline-block;
  padding: 5px;
}
</style>
</head>
<body>
<h2>Products</h2>

<input type="text" id="serachInput" onkeyup="searchFunction()" placeholder="Search for names.." title="Type in a name">
<br/>

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
	    		var html = "<tr><th>Name</td><td>Category</td><td>Price($)</td><td>Status</td></tr>";
	    		$.each(data, function(i, offer) {
	    		  
	    		   html += "<tr id='row_"+offer.id+"'><td>"+offer.id+"</td><td>"+offer.name+"</td><td>"+offer.category+"</td><td>"+offer.price+"</td>";
	    		   html += "<td><a href='javascript:void(0);' onclick='deleteOffer("+offer.id+")' id='iValid"+offer.id+"'> Valid </a></td><td>"+offer.eDate+"</td>";
	    		 
	    		});
	    		$("#empData").append(html);
	    		
	    		$('#empData td:nth-child(6)').hide();
	    		$('#empData td:nth-child(1)').hide();
	    		statusFunc();
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
  			    	 html += "<tr><td>"+$('#name').val()+"</td><td>"+$('#category').val()+"</td><td>"+$('#price').val()+"</td>";
  		    		 html += "<td><a href='javascript:void(0);' onclick='deleteOffer("+$('#id').val()+")' id='iValid"+$('#eDate').val()+"'> Valid </a></td>";
  					$("#empData").append(html);
  					$("#id").val("");
  					$("#name").val("");
  					$("#category").val("");
  					$("#price").val("");
  					$("#eDate").val("");
  					location.reload();
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
	var resDate = $('#eDate').val().substring(6, 10)+$('#eDate').val().substring(0, 2)+$('#eDate').val().substring(3, 5);
    var str= JSON.stringify({
    	"id": $('#id').val(),
        "name": $('#name').val(),
        "category": $('#category').val(),
        "price": $('#price').val(),
        "eDate": resDate
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
 function searchFunction() {
	  var input, filter, table, tr, td, i;
	  input = document.getElementById("serachInput");
	  filter = input.value.toUpperCase();
	  table = document.getElementById("empData");
	  tr = table.getElementsByTagName("tr");
	  for (i = 1; i < tr.length; i++) {
	    td = tr[i].getElementsByTagName("td")[1];
	    if (td) {
	      if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
	        tr[i].style.display = "";
	      } else {
	        tr[i].style.display = "none";
	      }
	    }       
	  }
	}
 
 $(function() {
   $("#eDate").datepicker();
 });

 function statusFunc(){ 
	
	 var d = new Date();
	 var acttualDate = String(d.getFullYear())+ String(d.getMonth() + 1)+String(d.getDate());

	  var table, tr, td, i, expireDate;
	  table = document.getElementById("empData");
	  tr = table.getElementsByTagName("tr");
	  
	  for (i = 1; i < tr.length; i++) {
	 	 expireDate = tr[i].getElementsByTagName("td")[5].innerHTML;
	 	 td = tr[i].getElementsByTagName("td")[0].innerHTML;
		 
		if( expireDate != null && expireDate<acttualDate){
			
			$('#iValid'+td).text('Expired').css( "color", "red" );
		}
		else {
			$("#iValid"+td).removeAttr('href').text('Valid').css( "color", "green" ); 
		}
	 }
 }
 
</script>
<br/><br/>

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
 	<td><input type="text" name="eDate" id="eDate"></td>
</tr>
<tr>
	<td></td>
 	<td><input type="submit" name="add" value="Add Offer"></td>
</tr>
</table>
</form>
</body>
</html>

