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

    var selectedProject = function () {
        return $('#projectsTable').attr('data-selected-project');
    };

    var datatableInitParams = {
        info: false,
        paging: false,
        ordering: false,
        language: {
            url: "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/German.json"
        }
    };

    return {
        isNumeric: isNumeric,
        urlParam: urlParam,
        selectedProject: selectedProject,
        datatableInitParams: datatableInitParams
    }

}

function showWorkPackageModal(projectId, projectName) {

    var plUtils = new ProjectListUtils();

    $('#modalBody').load(projectId + '/findWorkingPackages',
        function (response, status, xhr) {
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

    // convert all numbers to German
    $('.localeNumber').each(function (index, value) {
        var rawValue = $(this).text();
        var parsedValue = parseToGermanNumber(rawValue);
        $(this).text(parsedValue);
    });
});