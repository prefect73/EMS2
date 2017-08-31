$(document).ready(function() {
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	var responseJsonObject = [];
	
	var timeRecordingToSave = new Map();
	
	function myCallbackFunction (updatedCell, updatedRow, oldValue) {
		var id = updatedRow.node().id;
		var rowCopy =  updatedRow.data().slice();
		
		//remove first column
		rowCopy.shift();
		var hours = rowCopy.join(",");
		var monthIndex = $("#monthNamesDropDown").val();
		
		timeRecordingToSave.set(id, {id:id, hours: hours, monthIndex:monthIndex});
		
		console.log(timeRecordingToSave);
		
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