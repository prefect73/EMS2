<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Projects List</title>
	<link href="<c:url value='/static/css/bootstrap.css' />" rel="stylesheet"></link>
	<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
</head>

<body>
	<div class="generic-container">
		<%@include file="authheader.jsp" %>	
		<div class="panel panel-default">
			  <!-- Default panel contents -->
		  	<div class="panel-heading"><span class="lead">List of Projects </span></div>
			<table class="table table-hover">
	    		<thead>
		      		<tr>
				        <th>Project Number</th>
				        <th>Project Name</th>
				        <th>Customer Name</th>
				        <th>Offered Cost</th>
				        <th>Total Cost</th>
				        <!--  <th>Project Lead</th>-->
				        <!--<th>SSO ID</th>
				        <sec:authorize access="hasRole('ADMIN') or hasRole('DBA')">
				        	<th width="100"></th>
				        </sec:authorize>
				        <sec:authorize access="hasRole('ADMIN')">
				        	<th width="100"></th>
				        </sec:authorize>-->
				        
					</tr>
		    	</thead>
	    		<tbody>
				<c:forEach items="${projects}" var="project">
					<tr>
						<td>${project.projectNumber}</td>
						<td>${project.projectName}</td>
						<td>${project.customerName}</td>
						<td>${project.offeredCost}<td>
						<td>${project.totalCost}</td>
						<!-- <td>${users.firstName}</td>
						<sec:authorize access="hasRole('ADMIN') or hasRole('DBA')">
							<td><a href="<c:url value='/edit-user-${users.firstName}' />" class="btn btn-success custom-width">edit</a></td>
				        </sec:authorize>
				        <sec:authorize access="hasRole('ADMIN')">
							<td><a href="<c:url value='/delete-user-${users.firstName}' />" class="btn btn-danger custom-width">delete</a></td>
        				</sec:authorize>-->
					</tr>
				</c:forEach>
	    		</tbody>
	    	</table>
		</div>
		<!-- 
		<sec:authorize access="hasRole('ADMIN')">
		 	<div class="well">
		 		<a href="<c:url value='/newuser' />">Add New Project</a>
		 	</div>
	 	</sec:authorize>-->
   	</div>
</body>
</html>
