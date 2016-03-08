class Admin::ProductsController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :admin_required

  def index
    @product = Product.all
  end

  def show
    @product = Product.new(product_params)
  end

  def new
    @product = Product.new

    if @product.photo.present?
      @photo = @product.photo
    else
      @photo = @product.build_photo
    end
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])

    if @product.photo.present?
      @photo = @product.photo
    else
      @photo = @product.build_photo
    end
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to admin_products_path
    else
      render :edit
    end
  end



  private
  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, photo_attributes: [:image, :id])
  end

  def admin_required
    if !current_user.admin?
      redirect_to '/'
    end
  end

end
