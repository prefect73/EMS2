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
<title><spring:message code="paymentslist.title" /></title>
<link href="<c:url value='/static/css/bootstrap.css' />"
	rel="stylesheet"></link>
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.min.css" />
<script type="text/javascript"
	src="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.min.js"></script>
<script>
	$(document).ready(function() {
		
		if($("#defaultLanguage").val() == 'german'){
			$('#paymentsTable').DataTable({
		        "language": {
		            "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/German.json"
		        }
		    });
			
		} else if ($("#defaultLanguage").val() == 'english'){
			$('#paymentsTable').DataTable();
			
		} else {
			$('#paymentsTable').DataTable({
		        "language": {
		            "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/German.json"
		        }
		    });
			
		}
		
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
				<span class="lead"><spring:message code="paymentslist.title" />
				</span>
				<sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung')">
					<a class="btn btn-primary floatRight"
						href="<c:url value='/Payment/newpayment' />"><spring:message
							code="paymentslist.addNewProject" /></a>
				</sec:authorize>
			</div>
			<div id="paymentsTableWrapper" style="padding: 2%;">
				<table id="paymentsTable"
					class="table table-striped table-bordered dt-responsive nowrap"
					cellspacing="0" width="100%">
					<thead>
						<tr>
						<th><spring:message code="payment.label.workPackage" />
							</th>
							<th><spring:message code="payment.label.billed" />
							</th>
							<th><spring:message code="payment.label.billing" />
							</th>
							<th><spring:message code="payment.label.time" />
							</th>
							<th><spring:message code="payment.label.amount" />
							</th>
							<th><spring:message code="payment.label.remarks" />
							</th>
							<th><spring:message code="payment.label.finishedIn" />
							</th>
							<sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung') or hasRole('DBA')">
								<th width="100"></th>
							</sec:authorize>
							<sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung')">
								<th width="100"></th>
							</sec:authorize>
							
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${payments}" var="payment">
							<tr>
								<td>${payment.workPackage.workPackageName}</td>
								<td>${payment.billed}</td>
								<td>${payment.billing}</td>
								<td>${payment.time}</td>
								<td>${payment.amount}</td>
								<td>${payment.remarks}</td>
								<td>${payment.finishedIn}</td>
								
								<sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung') or hasRole('DBA')">
									<td><a
										href="<c:url value='/Payment/edit-payment-${payment.id}' />"
										class="btn btn-success "><spring:message code="button.edit" /></a></td>
								</sec:authorize>
								<sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung')">
									<td><a
										href="<c:url value='/Payment/delete-payment-${payment.id}' />"
										class="btn btn-danger"><spring:message code="button.delete" /></a></td>
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
