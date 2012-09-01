# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# To do: this code fragment repeats. Refactor the fragment to a function
jQuery ->
  owner                = $('#replace_expense_owner_owner_id').html()
  new_owner            = $('#replace_expense_owner_new_owner_id').html()
  owner_first_line     = "<option value=\"\">Please select</option>"
  new_owner_first_line = "<option value=\"\">Please select</option>"
  company              = $("#replace_expense_owner_company_id :selected").text()
  owner_options        = owner_first_line + $(owner).filter("optgroup[label='#{company}']").html()
  new_owner_options    = new_owner_first_line + $(new_owner).filter("optgroup[label='#{company}']").html()
  $("#replace_expense_owner_owner_id").html(owner_options)
  $("#replace_expense_owner_new_owner_id").html(new_owner_options)
  
  $('#replace_expense_owner_company_id').change ->
    company            = $("#replace_expense_owner_company_id :selected").text()
    owner_options      = owner_first_line + $(owner).filter("optgroup[label='#{company}']").html()
    new_owner_options  = new_owner_first_line + $(new_owner).filter("optgroup[label='#{company}']").html()
    $("#replace_expense_owner_owner_id").html(owner_options)
    $("#replace_expense_owner_new_owner_id").html(new_owner_options)