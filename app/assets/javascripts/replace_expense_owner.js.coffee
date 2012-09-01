# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# To do: this code fragment repeats. Refactor the fragment to a function
jQuery ->
  from_user            = $('#replace_expense_owner_from_user_id').html()
  to_user              = $('#replace_expense_owner_to_user_id').html()
  from_user_first_line = "<option value=\"\">Please select</option>"
  to_user_first_line   = "<option value=\"\">Please select</option>"
  company              = $("#replace_expense_owner_company_id :selected").text()
  from_user_options    = from_user_first_line + $(from_user).filter("optgroup[label='#{company}']").html()
  to_user_options      = to_user_first_line + $(to_user).filter("optgroup[label='#{company}']").html()
  $("#replace_expense_owner_from_user_id").html(from_user_options)
  $("#replace_expense_owner_to_user_id").html(to_user_options)
  
  $('#replace_expense_owner_company_id').change ->
    company              = $("#replace_expense_owner_company_id :selected").text()
    from_user_options    = from_user_first_line + $(from_user).filter("optgroup[label='#{company}']").html()
    to_user_options      = to_user_first_line + $(to_user).filter("optgroup[label='#{company}']").html()
    $("#replace_expense_owner_from_user_id").html(from_user_options)
    $("#replace_expense_owner_to_user_id").html(to_user_options)