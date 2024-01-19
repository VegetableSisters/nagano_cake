class Public::CartItemsController < ApplicationController
  
  def index
    @cart_items = current_customer.cart_items.all
  end

  def update
    @cart_items = CartItem.find(params[:id])
  end

  def destroy
    @cart_items = CartItem.find(params[:id])
    cart_item.destroy
    @cart_items = CartItem.all
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = CartItem.all
    cart_items.destroy_all
    redirect_to cart_items_path
  end

  def create
  @cart_item = current_customer.cart_items.new(cart_item_params)

  # 同じ商品がすでに存在するかしないか
  existing_cart_item = current_customer.cart_items.find_by(item_id: cart_item_params[:item_id])
  if existing_cart_item
    # 存在する場合、数量を更新
    existing_cart_item.amount += cart_item_params[:amount].to_i
    existing_cart_item.save
  else
    # 新しい商品なのでカートに追加
    @cart_item.save
  end
    redirect_to cart_items_path
  end
end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end