# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require crud

class currencies

  @action: () ->
    jQuery ->
      $('#currencies').dataTable
        sPaginationType: "full_numbers"
        bStateSave: true
        bJQueryUI: true
        bProcessing: true
        bServerSide: true
        sAjaxSource: $('#currencies').data('source')
        iDisplayLength: 20
        aLengthMenu: [[10, 20, 50, -1], [10, 20, 50, "All"]]
        aoColumns: [
          {
            bVisible: false
          }
          {
            sClass: "center_align"
          }
          null
        ]
        sDom: '<"H"lfr>t<"F"ip>T'
        fnRowCallback: (nRow, aData, iDisplayIndex, iDisplayIndexFull) ->
          if parseInt($.cookie("currencies_selected_row")) == aData[0]
            oTT = TableTools.fnGetInstance('currencies')
            oTT.fnSelect nRow
        oTableTools: {
          sRowSelect: "single"     
          aButtons : 
            crud.construct_buttons('currencies', 2)
          fnRowSelected: (node) ->
            currencies_id = TableTools.fnGetInstance('currencies').fnGetSelectedData()[0][0]
            $.cookie "currencies_selected_row", currencies_id, path: "/"
          fnRowDeselected: (node) ->
            $.cookie "currencies_selected_row", null, path: "/"
        }

currencies.action()