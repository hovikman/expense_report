# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require crud

class currencies

  @action: () ->
    jQuery ->
      $('#currencies').dataTable
        sPaginationType: "full_numbers"
        bStateSave: false
        bJQueryUI: true
        iDisplayLength: 20
        aLengthMenu: [[10, 20, 50, -1], [10, 20, 50, "All"]]
        aoColumns: [
          {bVisible: false}
           null
           null
        ]
        sDom: '<"H"lfr>t<"F"ip>T'
        oTableTools: {
          sRowSelect: "single"     
          aButtons : [
            # New
            {
              sExtends:    "text"
              sButtonText: "New"
              fnClick: () ->
                crud.crud_action('currencies', 'C')
            }

            # View
            {
              sExtends:    "text"
              sButtonText: "View"
              fnClick: () ->
                crud.crud_action('currencies', 'R')
            }

            # Edit
            {
              sExtends:    "text"
              sButtonText: "Edit"
              fnClick: () ->
                crud.crud_action('currencies', 'U')
            }

            # Delete
            {
              sExtends:    "text"
              sButtonText: "Delete"
              fnClick: () ->
                crud.crud_action('currencies', 'D', 2)
            }
          ]
        }

currencies.action()