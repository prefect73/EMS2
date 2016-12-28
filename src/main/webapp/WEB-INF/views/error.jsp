<%@ page language="java" contentType="text/html; charset=ISO-8859-15" pageEncoding="ISO-8859-15"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-15">
		<title><spring:message code="error.title"/></title>
<link href="<c:url value='/static/css/bootstrap.css' />"
	rel="stylesheet"></link>
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>
<body>
	<div class="generic-container">
		<%@include file="authheader.jsp"%>
<div>
	<h1 style="text-align: center;line-height:10em;"><spring:message code="error.message"/><a class="btn btn-danger custom-width" onclick="window.history.go(-1); return false;"><spring:message code="button.back"/></a></h1>
</div>
</div>
</body>
</html>
