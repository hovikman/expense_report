# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require crud

class expense_attachments
  
  @action: () ->
    jQuery ->
      $('#expense_attachments').dataTable
        sPaginationType: "full_numbers"
        bStateSave: true
        bJQueryUI: true
        bProcessing: true
        bServerSide: true
        bAutoWidth: false
        sAjaxSource: $('#expense_attachments').data('source')
        iDisplayLength: 10
        aLengthMenu: [[10, 20, 50, -1], [10, 20, 50, "All"]]
        aoColumns: [
          {
            bVisible: false
          }
          null
        ]
        aaSorting: [[ 1, "asc" ]]
        sDom: '<"H"lfr>t<"F"ip>T'
        fnRowCallback: (nRow, aData, iDisplayIndex, iDisplayIndexFull) ->
          if parseInt($.cookie("expense_attachments_selected_row")) == aData[0]
            oTT = TableTools.fnGetInstance('expense_attachments')
            oTT.fnSelect nRow
        oTableTools: {
          sRowSelect: "single"     
          aButtons : 
            crud.construct_buttons('expense_attachments', 1, true, 'expenses')
          fnRowSelected: (node) ->
            expense_attachment_id = TableTools.fnGetInstance('expense_attachments').fnGetSelectedData()[0][0]
            $.cookie "expense_attachments_selected_row", expense_attachment_id, path: "/"
          fnRowDeselected: (node) ->
            $.cookie "expense_attachments_selected_row", null, path: "/"
        }

expense_attachments.action()