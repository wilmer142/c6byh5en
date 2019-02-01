class Api::V1::ProductsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    @products = Product.all
    render json: @products
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      render json: @product, status: :ok
    else
      render json: {errors: @product.errors}, status: 422
    end
  end

  private 

    def product_params
      params.require(:product).permit(:name, :price)
    end
end
