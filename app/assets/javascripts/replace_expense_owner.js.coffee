# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

replace_expense_owner_update_controls = (owners) ->
  company    = $("#replace_expense_owner_company_id :selected").text()
  first_line = "<option value=\"\">Please select</option>"
  options    = first_line + $(owners).filter("optgroup[label='#{company}']").html()
  $("#replace_expense_owner_owner_id").html(options)
  $("#replace_expense_owner_new_owner_id").html(options)

jQuery ->
  owners = $('#replace_expense_owner_owner_id').html()
  replace_expense_owner_update_controls(owners)
  $('#replace_expense_owner_company_id').change ->
    replace_expense_owner_update_controls(owners)