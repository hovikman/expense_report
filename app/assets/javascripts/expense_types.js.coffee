# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require crud

class expense_types

  @action: () ->
    jQuery ->
      $('#expense_types').dataTable
        sPaginationType: "full_numbers"
        bStateSave: true
        bJQueryUI: true
        bProcessing: true
        bServerSide: true
        bAutoWidth: true
        sAjaxSource: $('#expense_types').data('source')
        iDisplayLength: 20
        aLengthMenu: [[10, 20, 50, -1], [10, 20, 50, "All"]]
        aoColumns: [
          {
            bVisible: false
          }
          null
          null
        ]
        sDom: '<"H"lfr>t<"F"ip>T'
        fnRowCallback: (nRow, aData, iDisplayIndex, iDisplayIndexFull) ->
          if parseInt($.cookie("expense_types_selected_row")) == aData[0]
            oTT = TableTools.fnGetInstance('expense_types')
            oTT.fnSelect nRow
        oTableTools: {
          sRowSelect: "single"     
          aButtons : 
            crud.construct_buttons('expense_types')
          fnRowSelected: (node) ->
            expense_type_id = TableTools.fnGetInstance('expense_types').fnGetSelectedData()[0][0]
            $.cookie "expense_types_selected_row", expense_type_id, path: "/"
          fnRowDeselected: (node) ->
            $.cookie "expense_types_selected_row", null, path: "/"
        }

expense_types.action()