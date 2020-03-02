<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,com.jndi.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<title>Select Insurance Plan</title>
</head>
<body>
<%
	String emailInput = (String) session.getAttribute("username"); 
	String patient_id = String.valueOf((Integer) session.getAttribute("userId"));
	String petname = request.getParameter("petname"); 
	String pettype = request.getParameter("pettype");
	String plan_id = request.getParameter("plan_id");
	/* String plan_name = request.getParameter("plan_name");
	String provider_name = request.getParameter("provider_name");
	String provider_id = request.getParameter("provider_id"); */

	Connection con = null;

	try {
		DataAccessLayer ob = new DataAccessLayer();
		con = ob.getConnection();
		// insert into paitent_plan table
		PreparedStatement ps = con.prepareStatement("insert into patient_plan (patient_id, plan_id, petname, pettype) values (?,?,?,?)");
		ps.setString(1, patient_id);
		ps.setString(2, plan_id);
		ps.setString(3, petname);
		ps.setString(4, pettype);
		int count = ps.executeUpdate();
		
		// check if update successful
		if (count>0) { 
		//pop a window showing plan successfully chosen
			out.println("<script>window.alert(\"Congratulations! You have successfully chosen the plan! \")</script>");

			// send email confirmation to patients
			PreparedStatement psip = con.prepareStatement("select * from insurance_plans where plan_id=?");
			psip.setString(1, plan_id);
		
			ResultSet rs = psip.executeQuery();
			if(rs.next()) {
				String providerName = rs.getString("PROVIDER_NAME");
				String planName = rs.getString("PLAN_NAME");
				SendEmail email = new SendEmail();
				email.sendPlanConfirm(emailInput, providerName, planName, petname);
			}	
		} else {
		//Show plan no chosen
			out.println("<script>window.alert(\"Sorry, something went wrong when choosing the plan. \")</script>");
		}
		String site = "insurance.html";
		response.setStatus(response.SC_MOVED_TEMPORARILY);
	    response.setHeader("Location", site);
	    
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		if(con != null) {
			try {
				con.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
%>

</body>
</html>
