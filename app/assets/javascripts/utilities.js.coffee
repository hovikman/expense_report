# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$.fn.dataTableExt.oApi.fnReloadAjax = (oSettings, sNewSource, fnCallback, bStandingRedraw) ->
  oSettings.sAjaxSource = sNewSource  if typeof sNewSource isnt "undefined" and sNewSource?
  
  # Server-side processing should just call fnDraw
  if oSettings.oFeatures.bServerSide
    @fnDraw()
    return
  @oApi._fnProcessingDisplay oSettings, true
  that = this
  iStart = oSettings._iDisplayStart
  aData = []
  @oApi._fnServerParams oSettings, aData
  oSettings.fnServerData.call oSettings.oInstance, oSettings.sAjaxSource, aData, ((json) ->
    
    # Clear the old information from the table 
    that.oApi._fnClearTable oSettings
    
    # Got the data - add it to the table 
    aData = (if (oSettings.sAjaxDataProp isnt "") then that.oApi._fnGetObjectDataFn(oSettings.sAjaxDataProp)(json) else json)
    i = 0

    while i < aData.length
      that.oApi._fnAddData oSettings, aData[i]
      i++
    oSettings.aiDisplay = oSettings.aiDisplayMaster.slice()
    if typeof bStandingRedraw isnt "undefined" and bStandingRedraw is true
      oSettings._iDisplayStart = iStart
      that.fnDraw false
    else
      that.fnDraw()
    that.oApi._fnProcessingDisplay oSettings, false
    
    # Callback user function - for event handlers etc 
    fnCallback oSettings  if typeof fnCallback is "function" and fnCallback?
  ), oSettings