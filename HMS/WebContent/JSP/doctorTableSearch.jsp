<%@ page import="java.sql.*,com.jndi.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.awt.Toolkit"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="javax.swing.ImageIcon"%>
<%@page import="java.awt.Image"%>
<%@page import="java.awt.image.BufferedImage"%>


<%
try
{
DataAccessLayer ob=new DataAccessLayer();
Connection con = ob.getConnection();
String specialisation=request.getParameter("specialisation");
String pettype=request.getParameter("pettype");
PreparedStatement ps;
ps=con.prepareStatement("select doctor_first_name, doctor_last_name, doctor_address, doctor_specialisation, doctor_id, picture from doctors where doctor_specialisation=?");
ps.setString(1, specialisation.trim());
ResultSet res=ps.executeQuery();
String imgLen = "";%>

<%
if (res.next()==true)
{
out.println("<div class='radio-group'>");
out.println("<table id=customers>");
out.println("<th>Name</th>");
out.println("<th>Address</th>");
out.println("<th>Specialisation</th>");
res.previous();

while(res.next())
{ 
    out.println("<tr>");
    out.println("</tr>");
    out.println("<tr class='radio' data-radio_value='" + res.getString(5) + "'>");
   //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   imgLen = res.getString(6);  
   System.out.println(imgLen.length());  
   int len = imgLen.length();  
   byte[] rb = new byte[len];  
   InputStream readImg = res.getBinaryStream(1);  
   int index = readImg.read(rb, 0, len);  
   System.out.println("Index.........." + index);  
  response.reset();  
   response.setContentType("image/jpg"); 
   out.println("<tr>");
   out.println("<td>");
   response.getOutputStream().write(rb, 0, len);  
   //response.getOutputStream().flush(); 
   out.println("</td>");
   out.println("</tr>");
   
   ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    out.println("<td class='non-selectable'>"+"Dr. "+res.getString(1)+" "+res.getString(2)+"</td>");
    out.println("<td class='non-selectable'>"+res.getString(3)+"</td>");
    out.println("<td class='non-selectable'>"+res.getString(4)+"</td>");
    out.println("</tr>");
           
}
out.println("</tbody>");
out.println("</table>");

out.println("<input style='display:none;' name='doctor_id' type='text' class='radio-input'");
out.println("</div>");
}
else
{
	out.println("<p id=customers><font size=3 color =red>No doctors exist with selected speciality.</font></p>");
}
con.close();
}
catch(Exception e)
{
	e.printStackTrace();
}

%>

