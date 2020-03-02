<%@ page import="java.sql.*,com.jndi.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="../js/displaypic.js"></script>
<link rel="stylesheet" type="text/css" href="../style/displaypic.css">
<link rel="stylesheet" type="text/css" href="../style/subpage.css">
</head>
<style>


.box {
    width:400px;
    height:300px;
    background-color:#;
    position:fixed;
    margin-left:-100px; /* half of width */
    margin-top:-100px;  /* half of height */
    top:20%;
    left:20%;
}

</style>
<body>

<div id="mySidenav" class="sidenav">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <a href="homepage.html">Home</a>
  <a href="viewProfile.jsp">My Profile</a>
  <a href="searchDoctors.html">Doctors</a>
  <a href="appointment.html">Appointment</a>
  <a href="#">Insurance</a>
  <a href="#">Emergency</a>
  <a href="Locator.html">Hospital Locator</a>
  <a href="#">Contact Us</a>
  <a href="#">Log Out</a>
</div>



<span style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776; open</span>

<script>
function openNav() {
    document.getElementById("mySidenav").style.width = "250px";
}

function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
}
</script>

<%
try
{
DataAccessLayer ob=new DataAccessLayer();
Connection con = ob.getConnection();
String accountTypeInput=(String)session.getAttribute("accountTypeInput");
String userName=(String)session.getAttribute("username");




	if (accountTypeInput.trim().equals("Doctor"))
	{   
		System.out.println("Going inside doctor if");
		PreparedStatement ps;
		ps=con.prepareStatement("Select doctor_first_name,doctor_last_name,doctor_address,doctor_specialisation,doctor_age from doctors where doctor_email=?");
		ps.setString(1, userName.trim());
		ResultSet res=ps.executeQuery();
		if(res.next())
		{    
			 
			 
		     out.println("Your profile:");
			 out.println("<table cellspacing=20 cellpadding=20 class='box'>");
	           out.println("<tbody>");
	           out.println("<tr>");
	           out.println("<td><b>Username</b></td>");
	           out.println("<td>"+userName+"</td>"); 
	           out.println("</tr>");  
	           out.println("<tr>");
	           out.println("<td><b>First Name</b></td>");
	           out.println("<td>"+res.getString(1)+"</td>");
	           out.println("</tr>");
	           out.println("<tr>");
	           out.println("<td><b>Last Name</b></td>");
	           out.println("<td>"+res.getString(2)+"</td>"); 
	           out.println("</tr>");
	           out.println("<tr>");
	           out.println("<td><b>Address</b></td>");
	           out.println("<td>"+res.getString(3)+"</td>"); 
	           out.println("</tr>");
	           out.println("<tr>");
	           out.println("<td><b>Specialization</b></td>");
	           out.println("<td>"+res.getString(4)+"</td>"); 
	           out.println("</tr>");
	           out.println("<tr>");
	           out.println("<td><b>Age</b></td>");
	           out.println("<td>"+res.getString(5)+"</td>"); 
	           out.println("</tr>"); 
	           out.println("</tbody>");
	           out.println("</table>");   
	           out.println("<table cellspacing=20 cellpadding=20>");	           
	           out.println("</tbody>");
	           out.println("</table>");  
		}
		
		
		con.close();
	}
	
	else if (accountTypeInput.trim().equals("Patient"))
	{   
		System.out.println("Going inside patient if");
		PreparedStatement ps;
		ps=con.prepareStatement("Select patient_firstname,patient_lastname,patient_address,patient_pet_type,pet_age from patients where patient_email=?");
		ps.setString(1, userName.trim());
		ResultSet res=ps.executeQuery();
		if(res.next())
		{    
			 
			
		     out.println("Your profile:");
			 out.println("<table cellspacing=20 cellpadding=20 class='box'>");
	           out.println("<tbody>");
	           out.println("<tr>");
	           out.println("<td><b>Username</b></td>");
	           out.println("<td>"+userName+"</td>"); 
	           out.println("</tr>");  
	           out.println("<tr>");
	           out.println("<td><b>First Name</b></td>");
	           out.println("<td>"+res.getString(1)+"</td>");
	           out.println("</tr>");
	           out.println("<tr>");
	           out.println("<td><b>Last Name</b></td>");
	           out.println("<td>"+res.getString(2)+"</td>"); 
	           out.println("</tr>");
	           out.println("<tr>");
	           out.println("<td><b>Address</b></td>");
	           out.println("<td>"+res.getString(3)+"</td>"); 
	           out.println("</tr>");
	           out.println("<tr>");
	           out.println("<td><b>Pet Type</b></td>");
	           out.println("<td>"+res.getString(4)+"</td>"); 
	           out.println("</tr>");
	           out.println("<tr>");
	           out.println("<td><b>Pet Age</b></td>");
	           out.println("<td>"+res.getString(5)+"</td>"); 
	           out.println("</tr>"); 
	           out.println("</tbody>");
	           out.println("</table>");   
	           out.println("<table cellspacing=20 cellpadding=20>");	           
	           out.println("</tbody>");
	           out.println("</table>");  
	           out.println("</div>");
		}
		
	}
	else if (accountTypeInput.trim().equals("Insurance Provider"))
	{   
		
		PreparedStatement ps;
		ps=con.prepareStatement("Select provider_name,provider_address from insurance_providers where provider_email=?");
		ps.setString(1, userName.trim());
		ResultSet res=ps.executeQuery();
		if(res.next())
		{    
			 
		     out.println("Your profile:");
			 out.println("<table cellspacing=20 cellpadding=20 class='box'>");
	           out.println("<tbody>");
	           out.println("<tr>");
	           out.println("<td><b>Username</b></td>");
	           out.println("<td>"+userName+"</td>"); 
	           out.println("</tr>");  
	           out.println("<tr>");
	           out.println("<td><b>Name</b></td>");
	           out.println("<td>"+res.getString(1)+"</td>");
	           out.println("</tr>");
	           out.println("<tr>");
	           out.println("<td><b>Address</b></td>");
	           out.println("<td>"+res.getString(2)+"</td>"); 
	           out.println("</tr>");
	           out.println("</tbody>");
	           out.println("</table>");   
	           out.println("<table cellspacing=20 cellpadding=20>");	           
	           out.println("</tbody>");
	           out.println("</table>");  
		}
		
	}
	else
	{%>
		echo ("<script>
		alert("Invalid Username");
		window.location.href='http://localhost:8080/HMS/JSP/loginForm.html';
		</script>");
	<%}
	
	con.close();
	
}
catch (Exception e)
{
	e.printStackTrace();
}
	


%>


</div>    
</body>
</html> 
 