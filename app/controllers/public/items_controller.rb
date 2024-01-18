class Public::ItemsController < ApplicationController
  def index
    # 以下、kaminariとransackの併用によるページネーション問題を克服したもの
    @search = Item.ransack(params[:q])
    @items = @search.result(distinct: true).page(params[:page]).per(5)
    @item_count = Item.count
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end