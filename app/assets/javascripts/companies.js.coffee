# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require crud

class companies

  @action: () ->
    jQuery ->
      $('#companies').dataTable
        sPaginationType: "full_numbers"
        bStateSave: true
        bJQueryUI: true
        bProcessing: true
        bServerSide: true
        bAutoWidth: true
        sAjaxSource: $('#companies').data('source')
        iDisplayLength: 20
        aLengthMenu: [[10, 20, 50, -1], [10, 20, 50, "All"]]
        aoColumns: [
          {
            bVisible: false
          }
          null
          null
          null
          {
            sClass: "center_align"
          }
        ]
        sDom: '<"H"lfr>t<"F"ip>T'
        fnRowCallback: (nRow, aData, iDisplayIndex, iDisplayIndexFull) ->
          if parseInt($.cookie("companies_selected_row")) == aData[0]
            oTT = TableTools.fnGetInstance('companies')
            oTT.fnSelect nRow
        oTableTools: {
          sRowSelect: "single"     
          aButtons : 
            crud.construct_buttons('companies')
          fnRowSelected: (node) ->
            companies_id = TableTools.fnGetInstance('companies').fnGetSelectedData()[0][0]
            $.cookie "companies_selected_row", companies_id, path: "/"
          fnRowDeselected: (node) ->
            $.cookie "companies_selected_row", null, path: "/"
        }

companies.action()