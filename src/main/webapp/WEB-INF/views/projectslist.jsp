<%@ page language="java" contentType="text/html; charset=ISO-8859-15"
         pageEncoding="ISO-8859-15" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-15">
    <title><spring:message code="projectslist.title"/></title>
    <link href="<c:url value='/static/css/bootstrap.css' />" rel="stylesheet"></link>
    <link rel="stylesheet" type="text/css"  href="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.min.css"/>
    <script src="https://code.jquery.com/jquery-3.2.1.js" integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE=" crossorigin="anonymous"></script>   
    <script src="<c:url value='/static/js/bootstrap.min.js' />"></script>
    <script src="<c:url value='/static/js/number-parser.js' />"></script>
    <script src="<c:url value='/static/js/tablesort/tablesort.js' />"></script>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous"></link>
    <link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
    <script type="text/javascript">
    $(document).ready(function () {
   		$('td.hiddenWhenCollaped').on('show.bs.collapse', function (e) {
   			$(this).removeClass("hiddenWhenCollaped")
    	});
   		$('td.hiddenWhenCollaped').on('hidden.bs.collapse', function (e) {
   			$(this).addClass("hiddenWhenCollaped")
    	});

   		// convert all numbers to german
        $('.localeNumber').each(function(index, value){
            var rawValue = $(this).text();
            var parsedValue = parseToGermanNumber(rawValue);
            $(this).text(parsedValue);
        });
    });
    </script>
    
   <!--   <script type="text/javascript"
            src="https://cdn.datatables.net/v/bs/jq-2.2.4/dt-1.10.13/datatables.js"></script>
    <script>
        $(document).ready(function () {

            if ($("#defaultLanguage").val() == 'german') {
                $('#projectsTable').DataTable({
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/German.json"
                    },
                    "order": [[1, "asc"]]
                });

            } else if ($("#defaultLanguage").val() == 'english') {
                $('#projectsTable').DataTable({
                    "order": [[1, "asc"]]
                });

            } else {
                $('#projectsTable').DataTable({
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/German.json"
                    },
                    "order": [[1, "asc"]]
                });

            }

        });
    </script>-->
</head>

<body>
<div class="generic-container">
    <input type="hidden" id="defaultLanguage" value='${defaultLanguage}'/>
    <%@include file="authheader.jsp" %>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading">
				<span class="lead"><spring:message code="projectslist.title"/>
				</span>
            <sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung')">
                <a class="btn btn-primary floatRight"
                   href="<c:url value='/Project/newproject' />"><spring:message
                        code="projectslist.addNewProject"/></a>
            </sec:authorize>
        </div>
        <div id="projectsTableWrapper" style="padding: 2%;">
            <table id="projectsTable"
                   class="table table-striped table-bordered dt-responsive nowrap  table-hover"
                   cellspacing="0" width="100%" style="font-size:100%;">
                <thead>
                <tr>
                    <th><spring:message code="project.label.projectNumber"/>
                    </th>
                    <th><spring:message code="project.label.projectName"/>
                    </th>
                    <th><spring:message code="project.label.customerName"/>
                    </th>
                    <%-- <th><spring:message code="project.label.yearName" />
                    </th>--%>
                    <sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung')">
                        <th><spring:message code="project.label.offeredCost"/>
                        </th>
                        <th><spring:message code="project.label.totalCost"/></th>
                    </sec:authorize>
                    <th><spring:message code="project.label.effectiveCost"/></th>
							<th><sec:authorize
									access="hasAnyRole('ADMIN', 'Projektleitung') or hasRole('DBA')">
								</sec:authorize> <sec:authorize
									access="hasAnyRole('ADMIN', 'Projektleitung') or hasRole('DBA')">
								</sec:authorize> <sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung')">

								</sec:authorize></th>
						</tr>
                </thead>
                <tbody>
                <c:forEach items="${projects}" var="project">
                    <tr>
                        <td>${project.projectNumber}</td>
                        <td><a role="button" data-toggle="collapse" href="#project${project.id}" aria-expanded="true" aria-controls="project${project.id}">${project.projectName}</a></td>
                        <td>${project.customerName}</td>
                        <sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung')">
                            <td><span class="localeNumber">${project.offeredCost}</span>&nbsp;<spring:message code="generic.currencySymbol"/></td>
                            <td><span class="localeNumber">${project.totalCost}</span>&nbsp;<spring:message code="generic.currencySymbol"/></td>
                        </sec:authorize>
                        <td><span class="localeNumber">${project.effectiveCost}</span>&nbsp;<spring:message code="generic.currencySymbol"/></td>
								<td style="text-align: center;"><sec:authorize
										access="hasAnyRole('ADMIN', 'Projektleitung')">
										<a class="btn btn-primary"
											title="<spring:message code="workPackageslist.addNewWorkPackage"/>"
											href="<c:url value='/WorkPackage/newworkPackage?projectId=${project.id}' />">
											<i class="fa fa-plus" aria-hidden="true"></i>
										</a>

									</sec:authorize> <sec:authorize
										access="hasAnyRole('ADMIN', 'Projektleitung') or hasRole('DBA')">
										<a
											href="<c:url value='/Project/edit-project-${project.projectNumber}' />"
											title="<spring:message code="button.edit"/>"
											class="btn btn-success ">
											<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
										</a>
									</sec:authorize> <sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung')">
										<a
											href="<c:url value='/Project/delete-project-${project.projectNumber}' />"
											title="<spring:message code="button.delete"/>"
											class="btn btn-danger">
											<i class="fa fa-trash" aria-hidden="true"></i>
										</a>
									</sec:authorize></td>
							</tr>
                    <tr data-sort-method='none'>
                        <td colspan="100" class="hiddenWhenCollaped">
                         <div class="collapse" id="project${project.id}">
                            <table class="table table-striped table-bordered dt-responsive nowrap table-hover" style="font-size:100%;" cellspacing="0" width="100%" >
											<thead>
												<tr>
													<th><spring:message code="workPackage.label.workPackageName" /></th>
													<sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung')">
														<th><spring:message code="workPackage.label.offeredCost" /></th>
														<th><spring:message code="workPackage.label.calculatedCost" /></th>
														<th><spring:message code="workPackage.label.totalCost" /></th>
														<th><spring:message code="workPackage.label.effectiveCost" /></th>
														<th><spring:message code="workPackage.label.workDoneInPercent" /></th>
														<th><spring:message code="workPackage.label.status" /></th>
													</sec:authorize>
													<th width="100"></th>
													<%--<sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung')">--%>
														<%--<th width="100"></th>--%>
													<%--</sec:authorize>--%>

												</tr>
											</thead>
								<tbody>
                                   <c:forEach items="${project.workPackages}" var="workPackage">
                                    <tr>
                                        <td>${workPackage.workPackageName}</td>
                                        <sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung')">
                                            <td><span class="localeNumber">${workPackage.offeredCost}</span>&nbsp;<spring:message code="generic.currencySymbol"/></td>
                                            <td><span class="localeNumber">${workPackage.calculatedCost}</span>&nbsp;<spring:message code="generic.currencySymbol"/></td>
                                            <td><span class="localeNumber">${workPackage.totalCost}</span>&nbsp;<spring:message code="generic.currencySymbol"/></td>
                                            <td><span class="localeNumber">${workPackage.effectiveCost}</span>&nbsp;<spring:message code="generic.currencySymbol"/></td>
                                            <td>${workPackage.workDoneInPercent}</td>
                                            <td style="text-align: center;">
                                                <spring:message code="workPackage.status.select.scheduled"
                                                                var="scheduled"/>
                                                <spring:message code="workPackage.status.select.delayed" var="delayed"/>
                                                <spring:message code="workPackage.status.select.problem" var="problem"/>
                                                <spring:message code="workPackage.status.select.finished"
                                                                var="finished"/>

                                                <c:choose>
                                                    <c:when test="${fn:containsIgnoreCase(workPackage.status,scheduled)}">
                                                        <%--<label style="color:lightgreen" class="form-control input-sm">--%>
                                                                <%--${workPackage.status}--%>
                                                        <%--</label>--%>
                                                        <i class="fa fa-calendar-check-o fa-2x" style="color:lightgreen;" aria-hidden="true" title="${workPackage.status}"></i>
                                                    </c:when>
                                                    <c:when test="${fn:containsIgnoreCase(workPackage.status,delayed)}">
                                                        <%--<label style="color:orange" class="form-control input-sm">--%>
                                                                <%--${workPackage.status}--%>
                                                        <%--</label>--%>
                                                        <i class="fa fa-clock-o fa-2x" style="color:orange;" aria-hidden="true" title="${workPackage.status}"></i>
                                                    </c:when>
                                                    <c:when test="${fn:containsIgnoreCase(workPackage.status,problem)}">
                                                        <%--<label style="color:red" class="form-control input-sm">--%>
                                                                <%--${workPackage.status}--%>
                                                        <%--</label>--%>
                                                        <i class="fa fa-exclamation-triangle fa-2x" style="color:red;" aria-hidden="true" title="${workPackage.status}"></i>
                                                    </c:when>
                                                    <c:when test="${fn:containsIgnoreCase(workPackage.status,finished)}">
                                                        <%--<label style="color:green" class="form-control input-sm">--%>
                                                                <%--${workPackage.status}--%>
                                                        <%--</label>--%>
                                                        <i class="fa fa-check-square fa-2x" style="color:green;" aria-hidden="true" title="${workPackage.status}"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${workPackage.status}
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </sec:authorize>
                                        <td colspan="2">
                                            <%-- <sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung') or hasRole('DBA')"> --%>
                                        <a
                                                href="<c:url value='/WorkPackage/edit-workPackage-${workPackage.id}' />"
                                                class="btn btn-success " title="<spring:message code="button.edit"/>"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></a>
                                            <%-- </sec:authorize> --%>
                                        <sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung')">
                                            <a
                                                    href="<c:url value='/WorkPackage/delete-workPackage-${workPackage.id}' />"
                                                    class="btn btn-danger " title="<spring:message code="button.delete"/>"><i class="fa fa-trash" aria-hidden="true"></i></a>

                                        </sec:authorize>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            </div>
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
