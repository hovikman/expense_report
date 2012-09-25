# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class expense_statuses
  @action: () ->
    jQuery ->
      $('#expense_statuses').dataTable
        sPaginationType: "full_numbers"
        bStateSave: true
        bJQueryUI: true
        iDisplayLength: 20
        aLengthMenu: [[10, 20, 50, -1], [10, 20, 50, "All"]]
        aoColumns: [
          {
            bVisible: false
          }
          null
        ]
        sDom: '<"H"lfr>t<"F"ip>T'
        oTableTools: {
          aButtons: []
        }

expense_statuses.action()