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
<c:choose>
	<c:when test="${edit}">
		<title><spring:message code="project.update.title" /></title>
	</c:when>
	<c:otherwise>
		<title><spring:message code="project.add.title" /></title>
	</c:otherwise>
</c:choose>
<link href="<c:url value='/static/css/bootstrap.css' />"
	rel="stylesheet"></link>
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="<c:url value='/static/jquery-editable-select/jquery-editable-select.js' />"></script>
<link href="<c:url value='/static/jquery-editable-select/jquery-editable-select.css' />"
          rel="stylesheet"></link>
<script src="<c:url value='/static/js/number-parser.js' />"></script>
<script>
	function yearDropdownFill(startYear, endYear, defaultYear) {
		console.log("start " + startYear + " end" + endYear);
		for (i = startYear; i <= endYear; i++) {

            var ifIsSelected = '';

            if(i === parseInt(defaultYear)){
                ifIsSelected = 'selected';
            } else {
                ifIsSelected = '';
            }

			$('#yearName').append($('<option '+ ifIsSelected + '/>').val(i).html(i));
		}

	}

	$(document).ready(
			function() {
				var startYear = '<c:out value="${yearNameStart}"/>';
				var endYear = '<c:out value="${yearNameEnd}"/>';
                var defaultYear = '<c:out value="${yearNameSelected}"/>';
				yearDropdownFill(startYear, endYear, defaultYear);
				var projectYear = '<c:out value="${project.yearName}"/>';
				//$('#yearName option[value="' + projectYear +'"]').prop('selected', true);
				$('#yearName option[value="' + projectYear + '"]').attr(
						"selected", "selected");
				var selectedLeadsIds = [];
				<c:forEach items="${project.users}" var="usr">
				selectedLeadsIds.push('${usr.id}');
				</c:forEach>
				$("#projLeads > option").each(function() {
					if ($.inArray(this.value, selectedLeadsIds) > -1) {
						$(this).attr("selected", "selected");
					}
				});
                // convert all numbers to German
                $('.localeNumber').each(function (index, value) {
                    var rawValue = $(this).val();
                    var parsedValue = parseToGermanNumber(rawValue);
                    $(this).val(parsedValue);
                });

                $( "#status" ).change(function() {
                    if($(this).val() == 'Planmäßig'){
                        $(this).css('color','lightgreen');
                    } else if($(this).val() == 'Verzögert'){
                        $(this).css('color','orange');
                    }  else if($(this).val() == 'Problem'){
                        $(this).css('color','red');
                    } else if($(this).val() == 'Abgeschlossen'){
                        $(this).css('color','green');
                    }
                });

                var statusVal = '<c:out value="${project.status}"/>';
                if(statusVal == 'Planmäßig'){
                    $('#status option[value=Planmäßig]').attr('selected','selected');
                    $('#status').css('color','lightgreen');
                } else if(statusVal == 'Verzögert'){
                    $('#status option[value=Verzögert]').attr('selected','selected');
                    $('#status').css('color','orange');
                }  else if(statusVal == 'Problem'){
                    $('#status option[value=Problem]').attr('selected','selected');
                    $('#status').css('color','red');
                } else if(statusVal == 'Abgeschlossen'){
                    $('#status option[value=Abgeschlossen]').attr('selected','selected');
                    $('#status').css('color','green');
                } else if(statusVal == 'Scheduled'){
                    $('#status option[value=Scheduled]').attr('selected','selected');
                    $('#status').css('color','lightgreen');
                } else if(statusVal == 'Delayed'){
                    $('#status option[value=Delayed]').attr('selected','selected');
                    $('#status').css('color','orange');
                }  else if(statusVal == 'Problem'){
                    $('#status option[value=Problem]').attr('selected','selected');
                    $('#status').css('color','red');
                } else if(statusVal == 'Finished'){
                    $('#status option[value=Finished]').attr('selected','selected');
                    $('#status').css('color','green');
                }
                // customer name selectbox



                // transform selectbox
                $('#customerNameDropDown').editableSelect();

                $("input#progressPaymentBtn").on("click", function(){
                    var percentage = $("input#progressPayment").val();
                    var projectid = $("input#id").val();
                    $.get("distributePayments/" + projectid + "/" + percentage, function(){
                        alert("Gespeichert!");
                        location.reload();
					});
				});
            });
</script>
</head>

<body>
	<div class="generic-container">
		<%@include file="authheader.jsp"%>
		<form:form method="POST" modelAttribute="project"
			class="form-horizontal">
			<c:choose>
				<c:when test="${edit}">
					<div class="well lead col-md-5">
						<spring:message code="project.update.title" />
					</div>
					<div class="well col-md-2">
						<input type="submit"
							value="<spring:message code="button.update"/>"
							class="btn btn-primary btn-sm" /> or <a
							href="<c:url value='/Project/projectslist' />"><spring:message
								code="button.cancel" /></a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="well lead col-md-5">
						<spring:message code="project.add.title" />
					</div>
					<div class="well col-md-2">
						<input type="submit" value="<spring:message code="button.add"/>"
							class="btn btn-primary btn-sm" /> or <a
							href="<c:url value='/Project/projectslist' />"><spring:message
								code="button.cancel" /></a>
					</div>
				</c:otherwise>
			</c:choose>


			<form:input type="hidden" path="id" id="id" />

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="projectNumber"><spring:message
							code="project.label.projectNumber" /> </label>
					<div class="col-md-3">
						<form:input type="text" path="projectNumber" id="projectNumber"
							class="form-control input-sm" readonly="true" />
						<div class="has-error">
							<form:errors path="projectNumber" class="help-inline" />
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="projectName"><spring:message
							code="project.label.projectName" /> </label>
					<div class="col-md-3">
						<form:input type="text" path="projectName" id="projectName"
							class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="projectName" class="help-inline" />
						</div>
					</div>
				</div>
			</div>
            <div class="row">
                <div class="form-group col-md-12">
                    <label class="col-md-2 control-lable" for="customerNameDropDown">
                        <spring:message code="project.label.customerName"/> </label>
                    <div class="col-md-3">
                        <form:select class="form-control input-sm" name="customerNameDropDown" path="customerName" id="customerNameDropDown">
                            <c:forEach items="${customers}" var="customer">
                                <form:option cssClass="form-control input-sm" value="${customer}" label="${customer}"/>
                            </c:forEach>
                        </form:select>
                    </div>
                </div>
            </div>

			<c:choose>
				<c:when test="${edit}">
					<title><spring:message code="project.update.title" /></title>
					<div class="row">
						<div class="form-group col-md-12">
							<label class="col-md-2 control-lable" for="yearName"><spring:message
									code="project.label.yearName" /></label>
							<div class="col-md-3">
								<%-- <form:input readonly="true" type="text" path="yearName" id="yearName"
							class="form-control input-sm" />
						 --%>
								<select class="form-control input-sm" id="yearName"
									name="yearName">
								</select>
								<div class="has-error">
									<form:errors path="yearName" class="help-inline" />
								</div>
							</div>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="row">
						<div class="form-group col-md-12">
							<label class="col-md-2 control-lable" for="yearName"><spring:message
									code="project.label.yearName" /></label>
							<div class="col-md-3">
								<%-- <form:input type="text" path="yearName" id="yearName"
							class="form-control input-sm" /> --%>
								<select class="form-control input-sm" id="yearName"
									name="yearName">
									<!-- 	<option class="form-control input-sm" value="2017">2017</option>
								<option class="form-control input-sm" value="2018">2018</option>
								<option class="form-control input-sm" value="2019">2019</option>
								<option class="form-control input-sm" value="2020">2020</option>
						 -->
								</select>
								<div class="has-error">
									<form:errors path="yearName" class="help-inline" />
								</div>
							</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="users"><spring:message
							code="project.label.projectLeads" /> </label>
					<div class="col-md-3">
						<form:select path="users" items="${projectleadslist}"
							id="projLeads" multiple="true" itemValue="id"
							itemLabel="firstName" class="form-control input-sm" />
						<div class="has-error">
							<form:errors path="users" class="help-inline" />
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="offeredCost"> <spring:message
							code="project.label.offeredCost" /> <spring:message
							code="generic.inCurrency" />
					</label>
					<div class="col-md-3">
						<form:input type="text" path="offeredCost" readonly="true" id="offeredCost"
							class="form-control input-sm localeNumber" />
						<div class="has-error">
							<form:errors path="offeredCost" class="help-inline" />
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="totalCost"> <spring:message
							code="project.label.totalCost" /> <spring:message
							code="generic.inCurrency" />
					</label>
					<div class="col-md-3">
						<form:input type="text" path="totalCost" id="totalCost"
							class="form-control input-sm localeNumber" readonly="true" />
						<div class="has-error">
							<form:errors path="totalCost" class="help-inline" />
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-12">
                    <label class="col-md-2 control-lable" for="calculatedCost"> <spring:message
                            code="project.label.calculatedCost"/> <spring:message
                            code="generic.inCurrency"/>
                    </label>
                    <div class="col-md-3">
                        <form:input type="text" path="calculatedCost" id="totalCost"
                                    class="form-control input-sm localeNumber" readonly="true"/>
                        <div class="has-error">
                            <form:errors path="calculatedCost" class="help-inline"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-md-12">
                    <label class="col-md-2 control-lable" for="effectiveCost">
                        <spring:message code="project.label.effectiveCost" /> <spring:message
                            code="generic.inCurrency" />
                    </label>
                    <div class="col-md-3">
                        <form:input type="text" path="effectiveCost" id="effectiveCost"
                                    class="form-control input-sm localeNumber" readonly="true" />
                        <div class="has-error">
                            <form:errors path="effectiveCost" class="help-inline" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-md-12">
                    <label class="col-md-2 control-lable" for="effectiveCost">
                        <spring:message code="project.label.paymentPercentage"/> <spring:message
                            code="generic.inCurrency"/>
                    </label>
                    <div class="col-md-3">
                        <form:input type="text" path="paymentPercentage" id="paymentPercentage"
                                    class="form-control input-sm localeNumber" readonly="true"/>
                        <div class="has-error">
                            <form:errors path="paymentPercentage" class="help-inline"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-md-12">
                    <label class="col-md-2 control-lable" for="workDoneInPercent">
                        <spring:message code="project.label.workDoneInPercent" />
                    </label>
                    <div class="col-md-3">
                        <form:select path="workDoneInPercent" cssClass="form-control input-sm">
                            <form:option value="0" label="0" />
                            <form:option value="10" label="10" />
                            <form:option value="20" label="20" />
                            <form:option value="30" label="30" />
                            <form:option value="40" label="40" />
                            <form:option value="50" label="50" />
                            <form:option value="60" label="60" />
                            <form:option value="70" label="70" />
                            <form:option value="80" label="80" />
                            <form:option value="90" label="90" />
                            <form:option value="100" label="100" />
                        </form:select>
                        <div class="has-error">
                            <form:errors path="workDoneInPercent" class="help-inline" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-md-12">
                    <label class="col-md-2 control-lable" for="status">
                        <spring:message code="project.label.status" />
                    </label>
                    <div class="col-md-3">
                        <select class="form-control input-sm" id="status" name="status">
                            <option class="form-control input-sm"
                                    value="<spring:message code="workPackage.status.select.scheduled" />"><spring:message
                                    code="workPackage.status.select.scheduled" /></option>
                            <option class="form-control input-sm"
                                    value="<spring:message code="workPackage.status.select.delayed" />"><spring:message
                                    code="workPackage.status.select.delayed" /></option>
                            <option class="form-control input-sm"
                                    value="<spring:message code="workPackage.status.select.problem" />"><spring:message
                                    code="workPackage.status.select.problem" /></option>
                            <option class="form-control input-sm"
                                    value="<spring:message code="workPackage.status.select.finished" />"><spring:message
                                    code="workPackage.status.select.finished" /></option>
                        </select>
                        <div class="has-error">
                            <form:errors path="status" class="help-inline" />
                        </div>
                    </div>
                </div>
            </div>
			<div class="row form-inline">
				<div class="form-group col-md-12">
					<label class="col-md-2 control-lable" for="progressPayment">
						<spring:message code="project.label.progressPayment" />&nbsp;(%)
					</label>
					<div class="col-md-3">
						<input type="text"  id="progressPayment"
									class="form-control input-sm localeNumber"/>
						<input style="float:right; margin-top: 5px;" class="btn btn-primary btn-sm" type="button" name="progressPaymentBtn" id="progressPaymentBtn" value="Abschlagszahlung">
					</div>
				</div>
			</div>
		</form:form>
	</div>
</body>
</html>