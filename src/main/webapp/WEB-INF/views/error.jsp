<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<c:choose>
	<c:when test="${edit}">
		<title>Update Project</title>
	</c:when>
	<c:otherwise>
		<title>Add Project</title>
	</c:otherwise>
</c:choose>
<link href="<c:url value='/static/css/bootstrap.css' />"
	rel="stylesheet"></link>
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>
<body>
	<div class="generic-container">
		<%@include file="authheader.jsp"%>
<div>
	<h1 style="text-align: center;line-height:10em;">Oops! Something went wrong.<a class="btn btn-danger custom-width" onclick="window.history.go(-1); return false;">Back</a></h1>
</div>
</div>
</body>
</html>
