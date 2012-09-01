# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# To do: this code fragment repeats. Refactor the fragment to a function
jQuery ->
  manager                = $('#replace_user_manager_manager_id').html()
  new_manager            = $('#replace_user_manager_new_manager_id').html()
  manager_first_line     = "<option value=\"\">Please select</option>"
  new_manager_first_line = "<option value=\"\">Please select</option>"
  company                = $("#replace_user_manager_company_id :selected").text()
  manager_options        = manager_first_line + $(manager).filter("optgroup[label='#{company}']").html()
  new_manager_options    = new_manager_first_line + $(new_manager).filter("optgroup[label='#{company}']").html()
  $("#replace_user_manager_manager_id").html(manager_options)
  $("#replace_user_manager_new_manager_id").html(new_manager_options)
  
  $('#replace_user_manager_company_id').change ->
    company              = $("#replace_user_manager_company_id :selected").text()
    manager_options      = manager_first_line + $(manager).filter("optgroup[label='#{company}']").html()
    new_manager_options  = new_manager_first_line + $(new_manager).filter("optgroup[label='#{company}']").html()
    $("#replace_user_manager_manager_id").html(manager_options)
    $("#replace_user_manager_new_manager_id").html(new_manager_options)