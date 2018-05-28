<%@ page language="java" contentType="text/html; charset=ISO-8859-15" pageEncoding="ISO-8859-15" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-15">
    <title>Forgot password</title>
    <link href="<c:url value='/static/css/bootstrap.css' />" rel="stylesheet"/>
    <link href="<c:url value='/static/css/app.css' />" rel="stylesheet"/>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>
<body>
<div class="generic-container">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">

            <c:choose>
                <c:when test="${error}">
                    <div class="panel panel-danger">
                        <div class="panel-heading">
                            <label><spring:message code="login.sentEmailErrorMessage"/></label>
                        </div>
                        <div class="panel-body">
                            <div class="alert alert-warning" role="alert">
                                <span class="glyphicon glyphicon-alert" aria-hidden="true"></span>
                                <span><spring:message code="login.sentEmailErrorMessage"/> <b>${email}</b></span>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="panel panel-success">
                        <div class="panel-heading">
                            <label><spring:message code="login.sentEmailSuccessMessageHeader"/></label>
                        </div>
                        <div class="panel-body">
                            <div class="alert alert-info" role="alert">
                                <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
                                <span><spring:message code="login.sentEmailSuccessMessage"/> <b>${email}</b></span>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
    </div>
</div>
</body>
</html>