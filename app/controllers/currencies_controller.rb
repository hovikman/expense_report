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
        format.html { redirect_to currencies_path, notice: "Currency #{@currency.code} was successfully created." }
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
        format.html { redirect_to currencies_path, notice: "Currency #{@currency.code} was successfully updated." }
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
    @currency.destroy

    respond_to do |format|
      format.html { redirect_to currencies_path, notice: "Currency #{@currency.code} was successfully deleted." }
      format.json { head :no_content }
    end
  end
end
