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


            <div class="panel panel-default">
                <div class="panel-heading">
                    <label><spring:message code="login.forgotPassword"/></label>
                </div>
                <div class="panel-body">
                    <form:form method="POST" class="form-horizontal" role="form">
                        <div class="row">
                            <div class="form-group col-md-12 has-feedback">
                                <label class="col-md-2 control-lable" for="password"><spring:message code="login.newPassword"/></label>
                                <div class="col-md-6">
                                    <input type="password" id="password" name="password" class="form-control input-sm"/>
                                    <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                                    <div class="has-error">
                                        <form:errors path="email" class="help-inline"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-2">
                                <input type="submit" value="<spring:message code="button.update"/>"
                                       class="btn btn-primary btn-sm"/>
                            </div>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>