<%@ page language="java" contentType="text/html; charset=ISO-8859-15" pageEncoding="ISO-8859-15"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-15">
		<title><spring:message code="accessDenied.title"/></title>
</head>
<body>
	<div class="generic-container">
		<div class="authbar">
			<span><spring:message code="generic.dear"/> <strong>${loggedinuser}</strong>, <spring:message code="accessDenied.message"/> </span> <span class="floatRight"><a href="<c:url value="/logout" />"><spring:message code="generic.logout"/></a></span>
		</div>
	</div>
</body>
</html>