function ProjectListUtils() {

    var isNumeric = function (n) {
        return !isNaN(parseFloat(n)) && isFinite(n);
    };
    var urlParam = function (name) {
        var results = new RegExp('[\?&]' + name + '=([^&#]*)')
            .exec(window.location.href);
        if (results != null) {
            return results[1] || "";
        } else {
            return null;
        }
    };
    
    var filterProjectsByWorkPackageName = function(workPackageName){
    	document.location.href = 'projectslist?workPackageName='+workPackageName;
    };

    var selectedProject = function () {
        return $('#projectsTable').attr('data-selected-project');
    };

    var datatableInitParams = {
        info: false,
        paging: false,
        ordering: false,
        language: {
//            url: "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/German.json"
        	  search: "Projekt-Suche:"
        },
        dom: "<'row'<'col-sm-6'><'col-sm-6'f>>" +
        	 "<'row'<'col-sm-12't>>" +
        	 "<'row'<'col-sm-5'i><'col-sm-7'p>>",
    };

    return {
        isNumeric: isNumeric,
        urlParam: urlParam,
        selectedProject: selectedProject,
        datatableInitParams: datatableInitParams,
        filterProjectsByWorkPackageName: filterProjectsByWorkPackageName
    }

}

function showWorkPackageModal(projectId, projectName) {

    var plUtils = new ProjectListUtils();

    $('#modalBody').load(projectId + '/findWorkingPackages',
        function (response, status, xhr) {
            // convert all numbers to German
            $('.localeNumber').each(function (index, value) {
                var rawValue = $(this).text();
                var parsedValue = parseToGermanNumber(rawValue);
                $(this).text(parsedValue);
            });
            
            plUtils.datatableInitParams.initComplete = function(settings, json) {
                // filter work packages, if needed
                var workPackageName = plUtils.urlParam("workPackageName");
                if(workPackageName != null && workPackageName != undefined && workPackageName != ""){
                	var filterWorkpackage = $('#modalBody .dataTables_filter input[type="search"]');
                	filterWorkpackage.val(workPackageName)
                	filterWorkpackage.trigger(jQuery.Event( 'keyup', { which: 50 }))
                }	
            };
            $('#workPackageModalTable').dataTable(plUtils.datatableInitParams);
            $('#modalTitle').html($('#workPackageModalTable').attr('data-project-name'));
            
            // open modal
            $('.modal').modal({
                keyboard: false,
                backdrop: false
            });
        });
}

$(document).ready(function () {

    var plUtils = new ProjectListUtils();

    plUtils.datatableInitParams.columnDefs = [
        {
            "targets": [ 0 ],
            "visible": false,
            "searchable": true
        },
        {
            "targets": [ 1 ],
            "visible": false,
            "searchable": true
        }
    ];

   $('#projectsTable').dataTable(plUtils.datatableInitParams);

    // bind filter events
    $("#isFinishedProject").change(function() {
    	var projectsDataTable = $('#projectsTable').DataTable();
        if(this.checked) {
        	projectsDataTable.columns(0).search('true').draw();
        }else{
        	projectsDataTable.columns(0).search('').draw();
        }
    });
    $("#isUserProject").change(function() {
    	var projectsDataTable = $('#projectsTable').DataTable();
        if(this.checked) {
        	projectsDataTable.columns(1).search('true').draw();
        }else{
        	projectsDataTable.columns(1).search('').draw();
        }
    });

    // if this page is an redirect -> open list of work packages
    var selectedProject = plUtils.selectedProject();
    if (selectedProject !== "" && plUtils.isNumeric(selectedProject)) {
        showWorkPackageModal(selectedProject);
    }else if (plUtils.isNumeric(plUtils.urlParam('projectId'))) {
        // if url container projectid param -> open this project
        showWorkPackageModal(plUtils.urlParam('projectId'));
    }
    
    // if you filter by work packages, 
    // set search value into field
    var workPackageName = plUtils.urlParam("workPackageName");
    if(workPackageName != null && workPackageName != undefined && workPackageName != ""){
    	$('#searchWorkPackageText').val(workPackageName);
    }

    $('td.hiddenWhenCollaped').on('show.bs.collapse', function (e) {
        $(this).removeClass("hiddenWhenCollaped")
    });
    $('td.hiddenWhenCollaped').on('hidden.bs.collapse', function (e) {
        $(this).addClass("hiddenWhenCollaped")
    });
    
    // filter projects by work package
    $("a[href='#searchWorkpackage']").on('click', function(e){
    	e.preventDefault();
    	var filterValue = $('#searchWorkPackageText').val();
    	plUtils.filterProjectsByWorkPackageName(filterValue);
    });

    // convert all numbers to German
    $('.localeNumber').each(function (index, value) {
        var rawValue = $(this).text();
        var parsedValue = parseToGermanNumber(rawValue);
        $(this).text(parsedValue);
    });
});