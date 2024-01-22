class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
  @items = Item.includes(:genre).page(params[:page]).per(10)
  @item_count = @items.total_count
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @genres = Genre.all
    @item = Item.new(item_params)
    @item.price = params[:item][:price]
    if @item.save
      redirect_to admin_item_path(item)
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    item.price = params[:item][:price]
    redirect_to admin_item_path
  end

  private
  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end

end
