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
  end
end
