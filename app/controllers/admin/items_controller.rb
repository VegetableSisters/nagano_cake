class Admin::ItemsController < ApplicationController
  # アクセス権限
  #before_action :authenticate_admin!

  def index
    @items = Item.all.page(params[:page]).per(5)
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    item = Item.new(item_params)
    item.price = params[:item][:price]
    item.save
    redirect_to admin_item_path(item)
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
