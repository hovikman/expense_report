# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require crud

class expense_details
  
  @action: () ->
    jQuery ->
      $('#expense_details').dataTable
        sPaginationType: "full_numbers"
        bStateSave: true
        bJQueryUI: true
        bProcessing: true
        bServerSide: true
        bAutoWidth: false
        sAjaxSource: $('#expense_details').data('source')
        iDisplayLength: 10
        aLengthMenu: [[10, 20, 50, -1], [10, 20, 50, "All"]]
        aoColumns: [
          {
            bVisible: false
          }
          {
            sClass: "center_align"
            sWidth: "25%"
          }
          {
            sWidth: "50%"
          }
          {
            sClass: "right_align"
            sWidth: "25%"
          }
        ]
        aaSorting: [[ 1, "desc" ]]
        sDom: '<"H"lfr>t<"F"ip>T'
        oTableTools: {
          sRowSelect: "single"     
          aButtons : 
              crud.construct_buttons('expense_details', 2, true, 'expenses')
        }

exchange_rate = (from_currency, to_currency, from_currency_code) ->
  $.get "/currencies/" + from_currency + "/get_exchange_rate/" + to_currency,
  ((response) ->
    if response > 0
      $('#expense_detail_exchange_rate').val(response)
      expense_details_update_total_amount()
    else
      alert("Cannot acquire exchange rate for '" + from_currency_code + "', please enter it manually.")),
  'text'
    
selected_currency_id = ->
  $('#expense_detail_currency_id').val()           

selected_currency_code = ->
  $('#expense_detail_currency_id option:selected').text()           

base_currency_id = ->
  $('#expense_detail_base_currency_id').text()          
    
expense_details_update_total_amount = ->
  total_amount = $('#expense_detail_amount').val() * $('#expense_detail_exchange_rate').val()
  total_amount = total_amount.toFixed(2)
  $('#expense_detail_total_amount').val(total_amount)
  
expense_details_update_controls = (refresh_exchange_rate) ->
  if base_currency_id() == selected_currency_id()
    $('#expense_detail_exchange_rate').val('1.00')
    $('#expense_detail_exchange_rate').prop "readOnly", true
    expense_details_update_total_amount()
  else
    if !$('#expense_detail_date').is('[readonly]')
      # we are in edit mode, not in view mode
      if refresh_exchange_rate
        exchange_rate(selected_currency_id(), base_currency_id(), selected_currency_code())
      $('#expense_detail_exchange_rate').prop "readOnly", false
  
$ ->
  expense_details_update_controls(false)

  $('#expense_detail_amount').change ->
    expense_details_update_total_amount()

  $('#expense_detail_exchange_rate').change ->
    expense_details_update_total_amount()
    
  $('#expense_detail_currency_id').change ->
    expense_details_update_controls(true)

  $("#expense_detail_date").datepicker
    showButtonPanel: true
    changeMonth: true
    changeYear: true
    dateFormat: "yy-mm-dd"        

  $('#expense_details_tabs').tabs()

expense_details.action()