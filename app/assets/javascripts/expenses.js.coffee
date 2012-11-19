# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require crud
  
class expenses
  @action: () ->
    jQuery ->
      $('#expenses').dataTable
        sPaginationType: "full_numbers"
        bStateSave: true
        bJQueryUI: true
        bProcessing: true
        bServerSide: true
        bAutoWidth: true
        sAjaxSource: $('#expenses').data('source')
        iDisplayLength: 10
        aLengthMenu: [[10, 20, 50, -1], [10, 20, 50, "All"]]
        aoColumns: [
          {
            bVisible: false
          }
          {
            sWidth: "16%"
          }
          {
            sClass: "center_align"
            sWidth: "19%"
          }
          {
            sWidth: "32%"
          }
          {
            sWidth: "18%"
          }
          {
            sClass: "right_align"
            sWidth: "15%"
          }
        ]
        aaSorting: [[ 2, "desc" ]]
        sDom: '<"H"lfr>t<"F"ip>T'
        fnPreDrawCallback: (oSettings) ->
          $('#expense_attachments').dataTable().fnReloadAjax('/expenses/0/expense_attachments.json')
          $('#expense_details').dataTable().fnReloadAjax('/expenses/0/expense_details.json')
          $("#transition_buttons").text('')
        fnRowCallback: (nRow, aData, iDisplayIndex, iDisplayIndexFull) ->
          if parseInt($.cookie("expenses_selected_row")) == aData[0]
            oTT = TableTools.fnGetInstance('expenses')
            oTT.fnSelect nRow
        oTableTools: {
          sRowSelect: "single"     
          aButtons : 
            crud.construct_buttons('expenses', 3)
          fnRowSelected: (node) ->
            expense_id = TableTools.fnGetInstance('expenses').fnGetSelectedData()[0][0]
            $("#transition_buttons").load('/expenses/' + expense_id + '/transition_buttons')
            $('#expense_attachments').dataTable().fnReloadAjax('/expenses/' + expense_id + '/expense_attachments.json')
            $('#expense_details').dataTable().fnReloadAjax('/expenses/' + expense_id + '/expense_details.json')
            $.cookie "expenses_selected_row", expense_id, path: "/"
          fnRowDeselected: (node) ->
            $('#expense_attachments').dataTable().fnReloadAjax('/expenses/0/expense_attachments.json')
            $('#expense_details').dataTable().fnReloadAjax('/expenses/0/expense_details.json')
            $("#transition_buttons").text('')
            $.cookie "expenses_selected_row", null, path: "/"
        }

$ ->
  $("#expense_submit_date").datepicker
    showButtonPanel: true
    changeMonth: true
    changeYear: true
    dateFormat: "yy-mm-dd"

expenses.action()