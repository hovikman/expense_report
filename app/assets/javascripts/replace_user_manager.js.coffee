# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

replace_user_manager_update_controls = (managers) ->
  company    = $("#replace_user_manager_company_id :selected").text()
  first_line = "<option value=\"\">Please select</option>"
  options    = first_line + $(managers).filter("optgroup[label='#{company}']").html()
  $("#replace_user_manager_manager_id").html(options)
  $("#replace_user_manager_new_manager_id").html(options)
  
jQuery ->
  managers = $('#replace_user_manager_manager_id').html()
  replace_user_manager_update_controls(managers)
  $('#replace_user_manager_company_id').change ->
      replace_user_manager_update_controls(managers)