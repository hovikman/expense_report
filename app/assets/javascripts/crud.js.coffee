# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class window.crud

  @crud_action: (sResource, sAction, nColumnIndex = 1, bNested = false, sParentResource = '', nParentId = 0) ->
    if sAction == 'C'
      if bNested
        sURL = '/' + sParentResource + '/' + nParentId + '/' + sResource + '/new'
      else
        sURL = '/' + sResource + '/new'
      window.location.href = sURL
    else
      sId = @selected_id(sResource)
      if sId == null
        alert('No row is selected!')
      else
        if sAction == 'R'
          sURL = '/' + sResource + '/' + sId
          window.location.href = sURL
        if sAction == 'U'
          sURL = '/' + sResource + '/' + sId + '/edit'
          window.location.href = sURL
        if sAction == 'D'
          sURL = '/' + sResource + '/' + sId
          sItemName = TableTools.fnGetInstance(sResource).fnGetSelectedData()[0][nColumnIndex]
          @delete_row(sURL, sItemName)

  @selected_id: (sResource) ->
    aData = TableTools.fnGetInstance(sResource).fnGetSelectedData()
    if aData.length == 0
      null
    else
      aData[0][0]

  @delete_row: (sURL, sItemName) ->
    href = $('<a ' +
               'id="delete_button" href="' + sURL + '" ' + 
               'data-confirm="Are you sure you want to delete \'' + sItemName + '\' ?" ' +
               'data-method="delete" ' +
               'rel="nofollow" ' +
               'hidden="true"' +
             '>' + 
           '</a>')
    $('body').append(href)
    $('#delete_button').click()
    $('#delete_button').remove()
   
  @construct_buttons: (sResource, nColumnIndex = 1, bNested = false, sParentResource = '', nParentId = 0) ->
    aColumns = [
      # New
      {
        sExtends:    "text"
        sButtonText: "New"
        fnClick: () ->
          crud.crud_action(sResource, 'C', nColumnIndex, bNested, sParentResource, nParentId)
      }

      # View
      {
        sExtends:    "text"
        sButtonText: "View"
        fnClick: () ->
          crud.crud_action(sResource, 'R')
      }

      # Edit
      {
        sExtends:    "text"
        sButtonText: "Edit"
        fnClick: () ->
          crud.crud_action(sResource, 'U')
      }

      # Delete
      {
        sExtends:    "text"
        sButtonText: "Delete"
        fnClick: () ->
          crud.crud_action(sResource, 'D', nColumnIndex)
      }
     ]
     
     return aColumns