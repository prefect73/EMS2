function ProjectListUtils() {

    var isNumeric = function (n) {
        return !isNaN(parseFloat(n)) && isFinite(n);
    };
    var urlParam = function (name) {
        var results = new RegExp('[\?&]' + name + '=([^&#]*)')
            .exec(window.location.href);
        if (results != null) {
            return results[1] || 0;
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
            url: "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/German.json"
        },
        dom: "<'row'<'col-sm-6'><'col-sm-6 safieBBine'f>>" +
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
            $('#workPackageModalTable').dataTable(plUtils.datatableInitParams);
            $('#modalTitle').html($('#workPackageModalTable').attr('data-project-name'));
            $('.modal').modal({
                keyboard: false,
                backdrop: false
            });
        });
}

$(document).ready(function () {

    var plUtils = new ProjectListUtils();

    $('#projectsTable').dataTable(plUtils.datatableInitParams);

    // if this page is an redirect -> open list of work packages
    var selectedProject = plUtils.selectedProject();
    if (selectedProject !== "" && plUtils.isNumeric(selectedProject)) {
        showWorkPackageModal(selectedProject);
    }else if (plUtils.isNumeric(plUtils.urlParam('projectId'))) {
        // if url container projectid param -> open this project
        showWorkPackageModal(plUtils.urlParam('projectId'));
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