# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class expenses_owned

  @action: () ->
    jQuery ->
      $('#expenses_owned').dataTable
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
          null
          null
          null
        ]
        sDom: '<"H"lfr>t<"F"ip>T'
        oTableTools: {
          sRowSelect: "single"     
          aButtons : [
            {
              sExtends:    "text"
              sButtonText: "Details"
              fnClick: () ->
                aData = TableTools.fnGetInstance('expenses_owned').fnGetSelectedData()
                if aData.length == 0
                  alert('No row is selected!')
                else
                  window.location.href = '/expenses/' + aData[0][0] + '/transition' 
            } 
          ]
        }
        
expenses_owned.action()