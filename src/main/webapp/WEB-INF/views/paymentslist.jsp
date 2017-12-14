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
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"
          integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous"></link>
<script type="text/javascript"
	src="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.min.js"></script>
<script>
	$(document).ready(function() {
		
		if($("#defaultLanguage").val() == 'german'){
			$('#paymentsTable').DataTable({
		        "language": {
		            "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/German.json"
		        },
                "order": [[ 0, "asc" ]],
                "pageLength": 20,
                "lengthMenu": [[10, 20, 50, -1], [10, 20, 50, "All"]]
		    });
			
		} else if ($("#defaultLanguage").val() == 'english'){
			$('#paymentsTable').DataTable({
                "order": [[ 0, "asc" ]],
                "pageLength": 20,
                "lengthMenu": [[10, 20, 50, -1], [10, 20, 50, "All"]]
            });
			
		} else {
			$('#paymentsTable').DataTable({
		        "language": {
		            "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/German.json"
		        },
                "order": [[ 0, "asc" ]],
                "pageLength": 20,
                "lengthMenu": [[10, 20, 50, -1], [10, 20, 50, "All"]]
		    });
			
		}
        $("#isBilled").change(function() {
            var paymentsTableToFilter =  $('#paymentsTable').DataTable();
            if(this.checked) {
                paymentsTableToFilter.columns(2).search('Nein').draw();
            }else{
                paymentsTableToFilter.columns(2).search('').draw();
            }
        });
        $("#isBilled").trigger('change');
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
            <div class="row" style="padding-left: 2%; padding-top: 10px;">
                <div class="col-md-2">
                    <div class="panel panel-default" style="margin-bottom: 0px;">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-7">
                                    <label class="control-label" for="isBilled"><spring:message code="payment.label.billed" /> </label>
                                </div>
                                <div class="col-md-3">
                                    <input id="isBilled" name="isBilled" type="checkbox" value="" checked/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
			<div id="paymentsTableWrapper" style="padding: 2%; overflow-x: auto;">
				<table id="paymentsTable"
					class="table table-striped table-bordered dt-responsive nowrap"
					cellspacing="0" width="100%">
					<thead>
						<tr>
							<th><spring:message code="payment.label.project" />
							</th>
							<th><spring:message code="payment.label.workPackage" />
							</th>
							<th><spring:message code="payment.label.billed" />
							</th>
							<th><spring:message code="payment.label.time" />
							</th>
							<th><spring:message code="payment.label.amount" />
							</th>
							<th><spring:message code="payment.label.remarks" />
							</th>
                            <th><spring:message code="payment.label.paymentPercentage"/></th>
                            <th></th>

						</tr>
					</thead>
					<tbody>
						<c:forEach items="${payments}" var="payment">
							<tr>
								<td>${payment.workPackage.project.projectName}</td>
								<td>${payment.workPackage.workPackageName}</td>
								<td>${payment.billed}</td>
								<td>${payment.time}</td>
								<td>${payment.amount}</td>
								<td>${payment.remarks}</td>
                                <td>${payment.paymentPercentage}</td>
								<td>
								<sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung') or hasRole('DBA')">
									<a
										href="<c:url value='/Payment/edit-payment-${payment.id}' />"
										class="btn btn-success " title="<spring:message code="button.edit" />"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></a>
								</sec:authorize>
								<sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung')">
									<a
										href="<c:url value='/Payment/delete-payment-${payment.id}' />"
										class="btn btn-danger" title="<spring:message code="button.delete" />"><i class="fa fa-trash" aria-hidden="true"></i></a>
								</sec:authorize>
                                </td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
