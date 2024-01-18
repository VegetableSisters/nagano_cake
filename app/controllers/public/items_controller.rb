class Public::ItemsController < ApplicationController
  def index
    @items = Item.active.page(params[:page]).per(5)
    @item_count = Item.active.count
  end

  def show
    @item = Item.find(params[:id])
  end
end
