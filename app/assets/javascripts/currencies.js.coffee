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
        oTableTools: {
          sRowSelect: "single"     
          aButtons : 
            crud.construct_buttons('currencies', 2)
        }

currencies.action()