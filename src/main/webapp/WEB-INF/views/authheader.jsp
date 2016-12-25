<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
	
<div class="authbar">
	<span>Dear <strong>${loggedinuser}</strong>, Welcome to EMS.
	</span> <span class="floatRight"><a href="<c:url value="/logout" />">Logout</a></span>
</div>
<div>
	<ul>
		<sec:authorize access="hasRole('ADMIN')">
		<li><a href="<c:url value='/list' />">Employees</a></li>
		</sec:authorize>
		<li><a href="<c:url value='/UserAttendance/userAttendanceslist' />">Emp Attendance</a></li>
		<sec:authorize access="hasRole('ADMIN')">
		<li><a href="<c:url value='/Project/projectslist' />">Projects</a></li>
		</sec:authorize>
				
		<!-- <li><a href="#">Emp Allocations</a></li> -->
		<sec:authorize access="hasRole('ADMIN')">
		<li><a href="<c:url value='/WorkPackage/workPackageslist' />">Employee WorkPackage Allocations</a></li>
		<!-- <li><a href="#">Time Planning</a></li> -->
		<li><a href="<c:url value='/Project/projectReport-0' />">Project Report</a></li>
		<li><a href="<c:url value='/UserAttendance/monthlyReport' />">Monthly Report</a></li>
		</sec:authorize>
	</ul>
</div>
