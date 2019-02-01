class Api::V1::ProductsController < ApplicationController

  skip_before_action :verify_authenticity_token

  before_action :find_product, only: [:update, :destroy]

  def index
    @products = Product.all
    render json: @products
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      render json: @product, status: :created
    else
      render json: {errors: @product.errors}, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product, status: 200
    else
      render json: {errors: @product.errors}, status: 422
    end
  end

  def destroy
    @product.destroy
    head :no_content
    render json: {message: "Producto Borrado"}, status: 204
  end

  private 

    def product_params
      params.require(:product).permit(:name, :price)
    end

    def find_product
      @product = Product.find(params[:id])
    end
end
