<%@ page language="java" contentType="text/html; charset=ISO-8859-15"
         pageEncoding="ISO-8859-15" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>

<table id="workPackageModalTable" class="table table-striped table-bordered dt-responsive nowrap table-hover" style="font-size: 100%;" cellspacing="0"
	width="100%">
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
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${workpackages}" var="workPackage">
			<tr>
				<td>${workPackage.workPackageName}</td>
				<sec:authorize access="hasAnyRole('ADMIN', 'Projektleitung')">
					<td><span class="localeNumber">${workPackage.offeredCost}</span>&nbsp;<spring:message code="generic.currencySymbol" /></td>
					<td><span class="localeNumber">${workPackage.calculatedCost}</span>&nbsp;<spring:message code="generic.currencySymbol" /></td>
					<td><span class="localeNumber">${workPackage.totalCost}</span>&nbsp;<spring:message code="generic.currencySymbol" /></td>
					<td><span class="localeNumber">${workPackage.effectiveCost}</span>&nbsp;<spring:message code="generic.currencySymbol" /></td>
					<td>${workPackage.workDoneInPercent}</td>
					<td style="text-align: center;"><spring:message code="workPackage.status.select.scheduled" var="scheduled" /> <spring:message
							code="workPackage.status.select.delayed" var="delayed" /> <spring:message code="workPackage.status.select.problem" var="problem" /> <spring:message
							code="workPackage.status.select.finished" var="finished" /> <c:choose>
							<c:when test="${fn:containsIgnoreCase(workPackage.status,scheduled)}">
								<i class="fa fa-calendar-check-o fa-2x" style="color: lightgreen;" aria-hidden="true" title="${workPackage.status}"></i>
							</c:when>
							<c:when test="${fn:containsIgnoreCase(workPackage.status,delayed)}">
								<i class="fa fa-clock-o fa-2x" style="color: orange;" aria-hidden="true" title="${workPackage.status}"></i>
							</c:when>
							<c:when test="${fn:containsIgnoreCase(workPackage.status,problem)}">
								<i class="fa fa-exclamation-triangle fa-2x" style="color: red;" aria-hidden="true" title="${workPackage.status}"></i>
							</c:when>
							<c:when test="${fn:containsIgnoreCase(workPackage.status,finished)}">
								<i class="fa fa-check-square fa-2x" style="color: green;" aria-hidden="true" title="${workPackage.status}"></i>
							</c:when>
							<c:otherwise>
                                            ${workPackage.status}
                                        </c:otherwise>
						</c:choose></td>
				</sec:authorize>
				<td colspan="2"><a href="<c:url value='/WorkPackage/edit-workPackage-${workPackage.id}' />" class="btn btn-success "
					title="<spring:message code="button.edit"/>"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></a> <sec:authorize
						access="hasAnyRole('ADMIN', 'Projektleitung')">
						<a href="<c:url value='/WorkPackage/delete-workPackage-${workPackage.id}' />" class="btn btn-danger " title="<spring:message code="button.delete"/>"><i
							class="fa fa-trash" aria-hidden="true"></i></a>

					</sec:authorize></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
