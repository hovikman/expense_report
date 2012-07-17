# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#currencies').dataTable
    sPaginationType: "full_numbers"
    bStateSave: false
    bJQueryUI: true
    iDisplayLength: 20
    aLengthMenu: [[10, 20, 50, -1], [10, 20, 50, "All"]]
    aoColumns: [
      {bVisible: false}
       null
       null
    ]
    sDom: '<"H"lfr>t<"F"ip>T'
    oTableTools: {
      sRowSelect: "single"     
      aButtons : [
                    # New
                    {
                      sExtends:    "text"
                      sButtonText: "New"
                      fnClick: () ->
                        crud_action('currencies', "C")
                    }

                    # View
                    {
                      sExtends:    "text"
                      sButtonText: "View"
                      fnClick: () ->
                        crud_action('currencies', "R")
                    }

                    # Edit
                    {
                      sExtends:    "text"
                      sButtonText: "Edit"
                      fnClick: () ->
                        crud_action('currencies', "U")
                    }

                    # Delete
                    {
                      sExtends:    "text"
                      sButtonText: "Delete"
                      fnClick: () ->
                        crud_action('currencies', "D")
                    }
                ]
    }

crud_action = (sResource, sAction) ->
  if sAction == "C"
     window.location.href = '/' + sResource + '/new'
  else
    sId = selected_id(sResource)
    if sId == null
      alert('No row is selected!')
    else
      if sAction == "R"
        sURL = '/' + sResource + '/' + sId
        window.location.href = sURL
      if sAction == "U"
        sURL = '/' + sResource + '/' + sId + '/edit'
        window.location.href = sURL
      if sAction == "D"
        sURL = '/' + sResource + '/' + sId
        sCode = TableTools.fnGetInstance(sResource).fnGetSelectedData()[0][1]
        delete_row(sURL, sCode)

selected_id = (sTable) ->
  aData = TableTools.fnGetInstance(sTable).fnGetSelectedData()
  if aData.length == 0
    null
  else
    aData[0][0]

delete_row = (sURL, sItemName) ->
  href = $('<a ' +
             'id="delete_button" href="' + sURL + '" ' + 
             'data-confirm="Are you sure you want to delete ' + sItemName + ' ?" ' +
             'data-method="delete" ' +
             'rel="nofollow" ' +
             'hidden="true"' +
           '>' + 
           '</a>')
  $('body').append(href)
  $('#delete_button').click()
  $('#delete_button').remove()

