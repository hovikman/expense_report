# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require crud

class users

  @action: () ->
    jQuery ->
      $('#users').dataTable
        sPaginationType: "full_numbers"
        bStateSave: true
        bJQueryUI: true
        bProcessing: true
        bServerSide: true
        bAutoWidth: true
        sAjaxSource: $('#users').data('source')
        iDisplayLength: 20
        aLengthMenu: [[10, 20, 50, -1], [10, 20, 50, "All"]]
        aoColumns: [
          {
            bVisible: false
          }
          null
          null
          null
        ]
        sDom: '<"H"lfr>t<"F"ip>T'
        fnRowCallback: (nRow, aData, iDisplayIndex, iDisplayIndexFull) ->
          if parseInt($.cookie("users_selected_row")) == aData[0]
            oTT = TableTools.fnGetInstance('users')
            oTT.fnSelect nRow
        oTableTools: {
          sRowSelect: "single"     
          aButtons : 
            crud.construct_buttons('users')
          fnRowSelected: (node) ->
            users_id = TableTools.fnGetInstance('users').fnGetSelectedData()[0][0]
            $.cookie "users_selected_row", users_id, path: "/"
          fnRowDeselected: (node) ->
            $.cookie "users_selected_row", null, path: "/"
        }

users_update_controls = (managers) ->
  company = $("#user_company_id :selected").text()
  first_line = "<option value=\"\">Please select</option>"
  options = first_line + $(managers).filter("optgroup[label='#{company}']").html()
  $("#user_manager_id").html(options)

jQuery ->
  managers = $('#user_manager_id').html()
  users_update_controls(managers)
  $('#user_company_id').change ->
    users_update_controls(managers)

users.action()