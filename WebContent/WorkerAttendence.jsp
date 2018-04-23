<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<jsp:include page="adminHeader.jsp" />
<title>STUDENT ATTENDANCE ::Faculty </title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.3/jquery.min.js"></script>

<style>
#myInput {
  background-image: url('https://www.google.co.in/search?q=search+icon+image&client=firefox-b-ab&dcr=0&tbm=isch&source=iu&ictx=1&fir=jH1i7qZ_rn3nkM%253A%252CI9B2Zmc5WhpplM%252C_&usg=__WXr3jl18HdjCdus6UA-78TSB5Uo%3D&sa=X&ved=0ahUKEwiU6dao8MrYAhVLs48KHas_Dx8Q9QEIMjAF&biw=1354&bih=659#imgrc=jH1i7qZ_rn3nkM:');
  background-position: 10px 10px;
  background-repeat: no-repeat;
  width: 100%;
  font-size: 16px;
  padding: 12px 20px 12px 40px;
  border: 1px solid #ddd;
  margin-bottom: 12px;
}
</style>
<%@page 
	import="java.util.*" 
	import="java.sql.*"
	import="sis.com.*"
	import="sis.com.controller.*" 
	import="sis.com.dao.*"
	import="sis.com.dao.impl.*"
	import="sis.com.bo.*"
	import="sis.com.daoFactory.*"
	import="java.text.SimpleDateFormat"
%>    
<%
java.util.Date date = new java.util.Date();
Long workerID=11L;

List<Worker> allList = new ArrayList<Worker>();
List<Long> allLeaveList = new ArrayList<Long>();

WorkerDao sd = DaoFactory.getWorkerDao();
allList=sd.getAllWorkers();
//allLeaveList=sd.getLeaveStudent();

Calendar cal = Calendar.getInstance();
SimpleDateFormat format = new SimpleDateFormat("dd MMM, YYYY");
java.util.Date _date = new java.util.Date();
String dateString = format.format(date);

if(session.getAttribute("updatedAttendance")!=null && (Boolean)session.getAttribute("updatedAttendance")!=true) {%>   
<div class="alert alert-danger alert-dismissable">
  <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
  <strong>Update Failed</strong> Please enter valid worker Id.
</div>
<%}else if(session.getAttribute("updatedAttendance")!=null && (Boolean)session.getAttribute("updatedAttendance")==true){%>
<div class="alert alert-success alert-dismissable">
  <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
  <strong>Updated</strong> 
</div>

<%}
session.removeAttribute("updatedAttendance");

if(session.getAttribute("inputError")!=null && (Boolean)session.getAttribute("inputError")==true) {%>   
<div class="alert alert-danger alert-dismissable">
  <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
  <strong>Input error</strong> please enter valid number.
</div>
<%
session.removeAttribute("inputError");
}%>

<%if(session.getAttribute("alreadyFilled")!=null && (Boolean)session.getAttribute("alreadyFilled")==true) {%>   
	<div class="alert alert-danger">
	  <strong>Already!</strong> Attendance must filled one time.
	</div>
	<%
	session.removeAttribute("alreadyFilled");
}%>
<!-- CONTAINER START -->
<div class="container container-sm border">
	<div class="container" >
		<header class="container announcement-sm" style="text-align: center;">
			<h1 style="font-family: 'Open Sans', sans-serif;">STUDENT ATTENDANCE</h1>
		</header>
		<hr>
		<div class="panel-group" id="accordion">
			<h2 style="text-align: center;">Today is : <%=dateString%></h2>
			<div class="well">	
				<input type="text" id="myInput" onkeyup="myFunction()" placeholder="Search for names.." title="Type in a name">
				<hr>
				<button style="float:right;margin:5px;" type="button" class="btn btn-info " data-toggle="modal" data-target="#updateAttendanceModal" >
					<span class="glyphicon glyphicon-pencil"></span>&nbsp;UPDATE
				</button>
				<form action="WorkerAttendanceController" method="post">
					<table id="myTable" class="table table-hover">
					  <tr class="header">
					    <th style="width:5%;">S.NO.</th>
					    <th style="width:10%;">worker ID</th>
					    <th style="width:50%;">NAME</th>
					    <th style="width:35%;">ATTENDANCE</th>
					  </tr>
					<%
					int i=1;
					for(Worker s:allList){
						workerID= s.getId();
						String name=s.getName();
						
					%>
					  <tr>
					    <td><%=i++%></td>
					    <td><%=workerID%></td>
					    <td><%=name%></td>
					    <td>
						    
					    	 <div class="form-group" style="float:left;width:32%;margin:left;">
							 <%--  <select class="form-control " id="sel1" name="<%=workerID%>"> --%>
							  	<%if(allLeaveList.contains(workerID)!=true){%>
							    	<!-- <option value="0">Absent</option> -->
							    	  <input value="0" name="<%=workerID%>"  type="radio" checked>Absent<br/>
							    	
					      		<%}else{ %>
							    	<!-- <option value="0" disabled>Absent</option> -->
					               <input value="0" name="<%=workerID%>"  type="radio" checked>Absent<br/>
							    	
					      		<%} %>
							    <%if(allLeaveList.contains(workerID)!=true){%>
							    	<!-- <option value="1">Present</option> -->
							   <input value="1" name="<%=workerID%>"  type="radio">Present<br/>
					      		<%}else{ %>
							    	<!-- <option value="1" disabled>Present</option> -->
							    <input value="1" name="<%=workerID%>" class="product-list" type="radio">Present<br/>
					      		<%} %>
					      		<%if(allLeaveList.contains(workerID)==true){%>
							    	<!-- <option value="2">Leave</option> -->							   
							    	<input value="2" name="<%=workerID%>" class="product-list" type="radio">Leave<br/>
							    	
							    	
					      		<%}else{ %>
							    	<!-- <option value="2">Leave</option> -->
							  <input value="2" name="<%=workerID%>" class="product-list" type="radio">Leave<br/>
							    	
					      		<%} %>
							  <!-- </select> -->
							</div> 
					    </td>
					  </tr>
					 
					<%}%>  
					</table>
					<input type="submit" class="btn btn-info" value="Submit Attendance">
					<br>
				</form>
				
				<!-- MODAL START -->
				<!-- Modal -->
				<div id="updateAttendanceModal" class="modal fade" role="dialog" style="margin-top:12%;">
				  <div class="modal-dialog">
				
				    <!-- Modal content-->
				    <div class="modal-content" >
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal">&times;</button>
				        <h4 class="modal-title">Update Attendance</h4>
				      </div>
				      <div class="modal-body">
				        <p>
				        	<form class="form-signin" action="UpdateWorkerAttendance" method="post">
					        	<div class="form-group">
								  <label for="usr">worker ID:</label>
								  <input type="text" class="form-control" id="subject" name="hostelId" required="" autofocus="" value="" />
								</div>
					        	<div class="form-group">
								  <label for="usr" style="float:left;">Attendance:</label>
								  <br>
									  <select class="form-control " id="sel1" name="attendance">
									    	<option value="0">Absent</option>
									    	<option value="1">Present</option>
									    	<option value="2">Leave</option>
									  </select>
								</div>
								<br>
								<button type="submit" class="btn btn-success">UPDATE &nbsp<span class="glyphicon glyphicon-ok"></span></button>						         
							</form>
				        </p>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				      </div>
				    </div>
				
				  </div>
				</div>
				<!-- MODAL END -->
				
				
				
			</div>
		</div>
	</div>
	<!-- WELL -->
</div>	
<!-- CONTAINER END -->
<script>
function myFunction() {
  var input, filter, table, tr, td, i;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
  table = document.getElementById("myTable");
  tr = table.getElementsByTagName("tr");
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[2];
    if (td) {
      if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }       
  }
}
</script>

<jsp:include page="footer.jsp"/>