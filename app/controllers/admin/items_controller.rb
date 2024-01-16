class Admin::ItemsController < ApplicationController
  # アクセス権限
  #before_action :authenticate_admin!

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    item = Item.new(item_params)
    item.save
    redirect_to '/top' #redirect先変更
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def update
  end

  private
  def item_params
    params.repuire(:item).permit(:name, :description, :tax_ex)
  end

end
