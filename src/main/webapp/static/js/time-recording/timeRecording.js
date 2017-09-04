$(document).ready(function() {

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");

	var responseJsonObject = [];

	var timeRecordingToSave = new Map();

	function myCallbackFunction (updatedCell, updatedRow, oldValue) {

		// update summary table
		var newValue = parseFloat(updatedCell.data());
		var floatOldValue = parseFloat(oldValue);	
		var columnIndex = updatedCell.index().column;
		var topSummaryTableColumn = $("table#summaryTable tbody tr th:nth-child("+((updatedCell.index().column) + 1 )+")");
		var topOldValue = parseFloat($(topSummaryTableColumn).text());

		var selectedTableId = updatedRow.context[0].sTableId;
		var numberOfRows = $('#'+selectedTableId + ' tbody tr').length;

		var projectSummary = 0.0;
		for(ij = 1; ij <= numberOfRows; ij++ ){
			projectSummary = projectSummary + parseFloat($('#'+selectedTableId+' tbody tr:nth-child('+ij+') td:nth-child('+(columnIndex +  1)+')').text())
		}
		// set project summary
		//  if number hasn't decimals, add zero
		if((projectSummary % 1) == 0){
			projectSummary = projectSummary + '.0';
		}
		$('#'+selectedTableId+' thead tr:nth-child(2) th:nth-child('+(columnIndex + 1)+')').html(projectSummary);
		
		var totalSummary = 0.0;
		var numberOfTables = $('table[id^=tmProjectDatatable').length;
		for(ji = 0; ji < numberOfTables; ji++){
			totalSummary = totalSummary + parseFloat($('table#tmProjectDatatable'+ji+' thead tr:nth-child(2) th:nth-child('+(columnIndex + 1)+')').text());
		}
		
		// set total summary
		if((totalSummary % 1) == 0){
			totalSummary = totalSummary + '.0';
		}
		$('#summarytable tbody tr:nth-child(1) th:nth-child('+(columnIndex + 1)+')').html(totalSummary);
		
		console.log('Final result:'+totalSummary);
		// end calculating summary

		var id = updatedRow.node().id;
		var rowCopy =  updatedRow.data().slice();

		//remove first column
		rowCopy.shift();
		var hours = rowCopy.join(",");
		var monthIndex = $("#monthNamesDropDown").val();

		timeRecordingToSave.set(id, {id:id, hours: hours, monthIndex:monthIndex});

		window.onbeforeunload = function(e) {
			var dialogText = 'Dialog text here';
			e.returnValue = dialogText;
			return dialogText;
		};
	}

	$('#closeModalAndReloadBtn').on('click', function (e) {
		location.reload();
	});
	// save recording data
	$("#saveInputDataBtn").on('click', function(event){
		event.preventDefault();


		// set loading spinner		
		$("#saveInputDataBtn").button('loading')

		// prepare date to send
		timeRecordingToSave.forEach(function(value, key, map){
			responseJsonObject.push({id:value.id, hours: value.hours, monthIndex:value.monthIndex});
		});

		$.ajax({
			type: "POST",
			url: '/EMS/timeRecording/save',
			data: JSON.stringify(responseJsonObject),
			contentType: "application/json",
			beforeSend: function(xhr) {
				xhr.setRequestHeader(header, token);
			},
			success: function(obj) {	 
				window.onbeforeunload = function(e){};
				setTimeout(function() {
					$("#saveInputDataBtn").button('reset');
				}, 100);
				$('#successDataSaved').modal({backdrop:false, keyboard:false})

			}})


	});

	$("table[id^='tmProjectDatatable']").each(function(i, el) {
		var table = $(this).DataTable({
			"paging" : false,
			"ordering" : false,
			"info" : false,
			"autoWidth": false,
			"searching" : false		
		});
		table.MakeCellsEditable({
			"onUpdate": myCallbackFunction,
			"inputCss":'inline-input-class'
		});


	});
});