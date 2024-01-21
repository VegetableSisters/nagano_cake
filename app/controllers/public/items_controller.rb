class Public::ItemsController < ApplicationController
  def index
    @search = Item.ransack(params[:q])
    @genres = Genre.all

    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @search.result(distinct: true).where(genre: @genre).page(params[:page]).per(6)
    else
      @items = @search.result(distinct: true).page(params[:page]).per(6)
    end

    @item_count = @items.total_count
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end
end
