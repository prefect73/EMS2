<%@ page language="java" contentType="text/html; charset=ISO-8859-15"
	pageEncoding="ISO-8859-15"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<table class="table table-striped table-bordered dt-responsive nowrap">
	<thead>
		<tr>
			<th>Projekt A</th>
			<c:forEach items="${monthSummary.tableHeader}" var="entry">
				<th><c:out value="${entry}" /></th>
			</c:forEach>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Summe Project</td>
			<c:forEach items="${monthSummary.tableBody}" var="entry">
				<th><c:out value="${entry}" /></th>
			</c:forEach>
		</tr>
		<tr>
		<td>Arbeitspaket 1</td>
		</tr>
<%-- 		<c:forEach items="${monthSummary.tableHeader}" var="entry">
			<th><c:out value="${entry}" /></th>
		</c:forEach> --%>
	</tbody>
</table>