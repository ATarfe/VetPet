<%@ page import="java.sql.*,com.jndi.*" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Provider's Patients</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="../style/main_new.css">
</head>
<body>

<%
try
{
DataAccessLayer ob=new DataAccessLayer();
Connection con = ob.getConnection();
String username = (String) session.getAttribute("username");
PreparedStatement ps;
String pname;
ps=con.prepareStatement("Select provider_name from insurance_providers where provider_email=?");
ps.setString(1, username.trim());
ResultSet res=ps.executeQuery();
if (res.next()==true)
{ pname=res.getString(1);

%>

	<!-- navbar -->  
	<nav class="navbar navbar-expand-lg fixed-top ">  
		<a class="navbar-brand" href="providerHome.jsp"></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">  
		<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse " id="navbarSupportedContent">
			<ul class="navbar-nav mr-4">
				<li class="nav-item">
				     <a class="nav-link" data-value="about" href="providerHome.jsp">Home</a>
				</li>  
				
				<li class="nav-item"> 
				    <a class="nav-link " data-value="providers" href="providerDoctors.jsp">Doctors</a>
				</li>   
				<li class="nav-item">  
				<!-- TODO -->
				   <a class="nav-link " data-value="team" href="providerPatients.jsp">My Patients</a>
				</li>  
				<li class="nav-item"> 
				<% out.println("<a class='nav-link' data-value='contact' href='#'>Welcome "+pname+"</a>");%>
				</li> 
				<li class="nav-item">  
				   <a class="nav-link " data-value="team" href="logout.jsp">Sign out</a>
				</li> 
			</ul> 
		</div>
	</nav>

<%}

	int providerId = (int) session.getAttribute("userId");
	PreparedStatement pspp = con.prepareStatement("select * from patient_plan where provider_id=?");
	pspp.setInt(1, providerId);
	ResultSet rspp = pspp.executeQuery();
	
	if(rspp.next()) {
		int i = 0;
		rspp.previous();
%>

	<div class="container" style="padding-top:100px;">
	<table class="table">
 	 <thead>
      <tr>
       <th scope="col">#</th>
       <th scope="col">Patient Name</th>
       <th scope="col">Plan Name</th>
       <th scope="col">Pet Name</th>
       <th scope="col">Pet Type</th>
      </tr>
     </thead>
     <tbody>
<%		
		
		while(rspp.next()) {
			String petname = rspp.getString("PETNAME");
			String pettype = rspp.getString("PETTYPE");
			String plan_name = rspp.getString("PLAN_NAME");
			
			PreparedStatement psInfo = con.prepareStatement("select * from patients where patient_id=?");
			psInfo.setInt(1, rspp.getInt("PATIENT_ID"));
			ResultSet rsInfo = psInfo.executeQuery();
			
			
			if(rsInfo.next()) {
				String pfname = rsInfo.getString("PATIENT_FIRSTNAME");
				String plname = rsInfo.getString("PATIENT_LASTNAME");
				
%>
	  <tr>
	   <th scope="row"> <% out.println(++i); %></th>
	    <td> <% out.println(pfname + " " + plname); %> </td>
	    <td> <% out.println(plan_name); %> </td>
	    <td> <% out.println(petname); %> </td>
	    <td> <% out.println(pettype); %>
	  </tr>

<%
				
			}
		}
%>

	</tbody>
	</table>
	</div>
	
<%
	}
	
	con.close();

}
catch(Exception e)
{
	e.printStackTrace();
}%>


	<!-- Posts section -->

		<div class="services" id="services">
			<div class="container">
			<h1 class="text-center">Our Services</h1>
				<div class="row">
					<div class="col-md-4 col-lg-4 col-sm-12">
						<div class="card">
							<div class="card-img">
								<img src="../pics/vet2.jpg" class="img-fluid">
							</div>
							
							<div class="card-body">
							<h4 class="card-title">Search Doctors</h4>
								<p class="card-text">
									
									Find vets with various specializations and book an appointment with them instantly.
								</p>
							</div>
							<div class="card-footer">
								<a href="scheduleAppointment.html" class="card-link">See more</a>
							</div>
						</div>
					</div>
					<div class="col-md-4 col-lg-4 col-sm-12">
						<div class="card">
							<div class="card-img">
								<img src="../pics/insurance.jpg" class="img-fluid">
							</div>
							
							<div class="card-body">
							   <h4 class="card-title">Insurance providers</h4>
								<p class="card-text">
									

									Pet insurance protects your four-legged family members.
								</p>
							</div>
							<div class="card-footer">
								<a href="" class="card-link">See more</a>
							</div>
						</div>
					</div>
					<div class="col-md-4 col-lg-4 col-sm-12">
						<div class="card">
							<div class="card-img">
								<img src="../pics/map.jpg" class="img-fluid">
							</div>
							
							<div class="card-body">
							<h4 class="card-title">Hospital Locator</h4>
								<p class="card-text">
									
									Wondering about nearby vets? They are just a click away.
								</p>
							</div>
							<div class="card-footer">
								<a href="" class="card-link">See more</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

</body>
</html>