<%@ page language="java" contentType="text/html; charset=ISO-8859-15"
	pageEncoding="ISO-8859-15"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-15">
<title><spring:message code="userslist.title" /></title>
<link href="<c:url value='/static/css/bootstrap.css' />"
	rel="stylesheet"></link>
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.min.css" />
<script type="text/javascript"
	src="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.min.js"></script>
<script src="<c:url value='/static/js/number-parser.js' />"></script>
<script>
$(document).ready(function() {
if($("#defaultLanguage").val() == 'german'){
	$('#usersTable').DataTable({
        "language": {
            "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/German.json"
        },
        "order": [[ 0, "asc" ]],
        "pageLength": 20,
        "lengthMenu": [[10, 20, 50, -1], [10, 20, 50, "All"]]
    });
	
} else if ($("#defaultLanguage").val() == 'english'){
	$('#usersTable').DataTable({
        "order": [[ 0, "asc" ]],
        "pageLength": 20,
        "lengthMenu": [[10, 20, 50, -1], [10, 20, 50, "All"]]
    });
	
} else {
	$('#usersTable').DataTable({
        "language": {
            "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/German.json"
        },
        "order": [[ 0, "asc" ]],
        "pageLength": 20,
        "lengthMenu": [[10, 20, 50, -1], [10, 20, 50, "All"]]
    });
}
    // convert all numbers to German
    $('.localeNumber').each(function (index, value) {
        var rawValue = $(this).text();
        var parsedValue = parseToGermanNumber(rawValue);
        $(this).text(parsedValue);
    });
});
</script>
</head>

<body>
	<div class="generic-container">
		<input type="hidden" id="defaultLanguage" value='${defaultLanguage}' />
		<%@include file="authheader.jsp"%>
		<div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading">
				<span class="lead"><spring:message code="userslist.title" /></span>
				<sec:authorize access="hasRole('ADMIN')">
					<a class="btn btn-primary floatRight"
						href="<c:url value='/newuser' />"><spring:message code="userslist.addNewEmployee" /></a>
				</sec:authorize>
			</div>
			<div id="usersTableWrapper" style="padding: 2%;">
				<table id="usersTable"
					class="table table-striped table-bordered dt-responsive nowrap"
					cellspacing="0" width="100%">
					<thead>
						<tr>
							<th><spring:message code="user.label.firstName" /></th>
							<th><spring:message code="user.label.lastName" /></th>
							<th><spring:message code="user.label.email" /></th>
							<th><spring:message code="user.label.ssoId" /></th>
							<th><spring:message code="user.label.perDayCost" /></th>
							<sec:authorize access="hasRole('ADMIN')">
								<th width="100"></th>
							</sec:authorize>
							<sec:authorize access="hasRole('ADMIN')">
								<th width="100"></th>
							</sec:authorize>

						</tr>
					</thead>
					<tbody>
						<c:forEach items="${users}" var="user">
							<tr>
								<td>${user.firstName}</td>
								<td>${user.lastName}</td>
								<td>${user.email}</td>
								<td>${user.ssoId}</td>
								<td><span class="localeNumber">${user.perDayCost}</span></td>
								<sec:authorize access="hasRole('ADMIN')">
									<td><a href="<c:url value='/edit-user-${user.id}' />"
										class="btn btn-success "><spring:message code="button.edit" /></a></td>
								</sec:authorize>
								<sec:authorize access="hasRole('ADMIN')">
									<td><a href="<c:url value='/delete-user-${user.id}' />"
										class="btn btn-danger "><spring:message code="button.delete" /></a></td>
								</sec:authorize>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>