class StockPricesController < ApplicationController
  before_action :set_stock_price, only: [:show, :update, :destroy]

  # GET /stock_prices
  def index
    @stock_prices = StockPrice.all

    render json: @stock_prices
  end

  # GET /stock_prices/1
  def show
    render json: @stock_price
  end

  # POST /stock_prices
  def create
    @stock_price = StockPrice.new(stock_price_params)

    if @stock_price.save
      render json: @stock_price, status: :created, location: @stock_price
    else
      render json: @stock_price.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stock_prices/1
  def update
    if @stock_price.update(stock_price_params)
      render json: @stock_price
    else
      render json: @stock_price.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stock_prices/1
  def destroy
    @stock_price.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock_price
      @stock_price = StockPrice.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def stock_price_params
      params.fetch(:stock_price, {})
    end
end
