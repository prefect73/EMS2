$(document).ready(function() {
	function myCallbackFunction (updatedCell, updatedRow, oldValue) {
		console.log("The new value for the cell is: " + updatedCell.data());
		console.log("The values for each cell in that row are: " + updatedRow.data());
	}

	$("table[id^='tmProjectDatatable']").each(function(i, el) {
		var table = $(this).DataTable({
			"paging" : false,
			"ordering" : false,
			"info" : false,
			"autoWidth": false,
			"searching" : false,
			"createdRow": function ( row, data, index ) {
				console.log(row);
			}		
	});
		table.MakeCellsEditable({
			"onUpdate": myCallbackFunction,
			 "inputCss":'my-input-class'
		});


});
});