# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require crud

class expense_details
  
  @action: () ->
    jQuery ->
      expense_id = $('#expense_id').text()
      $('#expense_details').dataTable
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
          null
          null
        ]
        sDom: '<"H"lfr>t<"F"ip>T'
        oTableTools: {
          sRowSelect: "single"     
          aButtons : 
              crud.construct_buttons('expense_details', 2, false, '', true, 'expenses', expense_id)
        }

$ ->
  $('#expense_detail_amount').change ->
    total_amount = $('#expense_detail_amount').val() * $('#expense_detail_exchange_rate').val()
    $('#expense_detail_total_amount').val(total_amount)

$ ->
  $('#expense_detail_exchange_rate').change ->
    total_amount = $('#expense_detail_amount').val() * $('#expense_detail_exchange_rate').val()
    $('#expense_detail_total_amount').val(total_amount)       
        
$ ->
  $("#expense_detail_date").datepicker
    showButtonPanel: true
    changeMonth: true
    changeYear: true
    dateFormat: "yy-mm-dd"        

expense_details.action()