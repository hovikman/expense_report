# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require crud

class expenses

  @action: () ->
    jQuery ->
      $('#expenses').dataTable
        sPaginationType: "full_numbers"
        bStateSave: false
        bJQueryUI: true
        iDisplayLength: 20
        aLengthMenu: [[10, 20, 50, -1], [10, 20, 50, "All"]]
        aoColumns: [
          {
            bVisible: false
          }
          null
          {
            sClass: "center_align"
          }
          null
          null
          {
            sClass: "right_align"
          }
        ]
        sDom: '<"H"lfr>t<"F"ip>T'
        oTableTools: {
          sRowSelect: "single"     
          aButtons : 
            crud.construct_buttons('expenses', 3, true, 'expense_details')
        }

$ ->
  $("#expense_submit_date").datepicker
    showButtonPanel: true
    changeMonth: true
    changeYear: true
    dateFormat: "yy-mm-dd"

expenses.action()