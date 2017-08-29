$(document).ready(function() {
	function myCallbackFunction (updatedCell, updatedRow, oldValue) {
		var id = updatedRow.node().id;
		updatedRow.data().shift();
		var hours = updatedRow.data().join(",");
		var monthName = $("#monthNamesDropDown").val();
		
		axios.get('/EMS/timeRecording/save', {
			params:{
				id: id,
				hours: hours,
				monthName:monthName	
			}
		})
		.then(function (response) {
			location.reload();
		})
		.catch(function (error) {
			console.log(error);
		});
		
	}

	$("table[id^='tmProjectDatatable']").each(function(i, el) {
		var table = $(this).DataTable({
			"paging" : false,
			"ordering" : false,
			"info" : false,
			"autoWidth": false,
			"searching" : false		
	});
		table.MakeCellsEditable({
			"onUpdate": myCallbackFunction
		});


});
});