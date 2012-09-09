require 'open-uri'
require 'rexml/document'

class CurrenciesController < ApplicationController
  load_and_authorize_resource

  # GET /currencies
  # GET /currencies.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @currencies }
    end
  end

  # GET /currencies/1
  # GET /currencies/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @currency }
    end
  end

  # GET /currencies/new
  # GET /currencies/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @currency }
    end
  end

  # GET /currencies/1/edit
  def edit
  end

  # POST /currencies
  # POST /currencies.json
  def create
    respond_to do |format|
      if @currency.save
        format.html { redirect_to currencies_path, notice: "Currency '#{@currency.code}' was successfully created." }
        format.json { render json: @currency, status: :created, location: @currency }
      else
        format.html { render action: "new" }
        format.json { render json: @currency.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /currencies/1
  # PUT /currencies/1.json
  def update
    respond_to do |format|
      if @currency.update_attributes(params[:currency])
        format.html { redirect_to currencies_path, notice: "Currency '#{@currency.code}' was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @currency.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /currencies/1
  # DELETE /currencies/1.json
  def destroy
    begin
       @currency.destroy
       notification = "Currency '#{@currency.code}' was successfully deleted."
    rescue Exception => e
      notification = e.message
    end

    respond_to do |format|
      format.html { redirect_to currencies_path, notice: "#{notification}" }
      format.json { head :no_content }
    end
  end
  
  def get_exchange_rate
    # get currency codes
    from_currency_code = Currency.find(params[:from_currency_id]).code
    to_currency_code   = Currency.find(params[:to_currency_id]).code

    # in case of error from the web service, exchange_rate remains 0 
    exchange_rate = 0  

     # Fetch a resource: an XML document with exchange rate.
    xml = open("http://www.webservicex.net/CurrencyConvertor.asmx/ConversionRate?FromCurrency=#{from_currency_code}&ToCurrency=#{to_currency_code}").read
  
    # Parse the XML document into a data structure.
    document = REXML::Document.new(xml)
  
    # Use XPath to find the interesting part of the data structure.
    REXML::XPath.each(document, '//double') do |rate|
      exchange_rate = rate[0]
    end       
 
    respond_to do |format|
      format.text { render :text => "#{exchange_rate}" }
    end
  end
end