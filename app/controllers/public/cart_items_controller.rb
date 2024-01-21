class Public::CartItemsController < ApplicationController
before_action :authenticate_customer!, only: [:create, :update, :destroy, :destroy_all]

def index
  @cart_items = current_customer.cart_items.all
end

def update
  @cart_items = CartItem.find(params[:id])
end

def destroy
  cart_item = CartItem.find(params[:id])
  cart_item.destroy
  redirect_to cart_items_path
end
def destroy_all
  current_customer.cart_items.destroy_all
  redirect_to cart_items_path
end
def create
  unless customer_signed_in?
  redirect_to new_customer_session_path
  return
  end
  @cart_item = current_customer.cart_items.new(cart_item_params)
  existing_cart_item = current_customer.cart_items.find_by(item_id: cart_item_params[:item_id])
  if existing_cart_item
  existing_cart_item.amount += cart_item_params[:amount].to_i
  redirect_to cart_items_path if existing_cart_item.save
  else
  redirect_to cart_items_path if @cart_item.save
  end
end

private
def cart_item_params
  params.require(:cart_item).permit(:item_id, :amount)
end
end