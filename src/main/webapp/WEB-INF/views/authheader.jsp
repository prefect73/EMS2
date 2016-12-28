<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-15" pageEncoding="ISO-8859-15"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
	
<div class="authbar">
	<span><spring:message code="generic.dear"/> <strong>${loggedinuser}</strong>, <spring:message code="generic.welcomeMessage"/>
	</span> <span class="floatRight"><a href="<c:url value="/logout" />"><spring:message code="generic.logout"/></a></span>
</div>
<div>
	<ul>
		<sec:authorize access="hasRole('ADMIN')">
		<li><a href="<c:url value='/list' />"><spring:message code="authheader.menu.employees"/></a></li>
		</sec:authorize>
		<li><a href="<c:url value='/UserAttendance/userAttendanceslist' />"><spring:message code="authheader.menu.emp.attendance"/></a></li>
		<sec:authorize access="hasRole('ADMIN')">
		<li><a href="<c:url value='/Project/projectslist' />"><spring:message code="authheader.menu.projects"/></a></li>
		</sec:authorize>
				
		<!-- <li><a href="#">Emp Allocations</a></li> -->
		<sec:authorize access="hasRole('ADMIN')">
		<li><a href="<c:url value='/WorkPackage/workPackageslist' />"><spring:message code="authheader.menu.employee.workPackage.allocations"/></a></li>
		<!-- <li><a href="#">Time Planning</a></li> -->
		 <li><a href="<c:url value='/Project/projectReport-0- ' />"><spring:message code="authheader.menu.projectReport"/></a></li>
		<li><a href="<c:url value='/UserAttendance/monthlyReport' />"><spring:message code="authheader.menu.monthlyReport"/></a></li>
		</sec:authorize>
	</ul>
</div>
