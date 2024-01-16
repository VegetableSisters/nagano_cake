class Public::OrdersController < ApplicationController
  # アクセス権限
  before_action :authenticate_customer!
  
  def new
    @order = Order.new
  end

  def confirm
    @shipping_cost = 800
    @selected_pay_method = params[:order][:pay_method]
    @cart_items = CartItem.where(customer_id: current_customer.id)
  
    # 商品合計額の計算
    ary = []
    @cart_items.each do |cart_item|
      ary << cart_item.item.price * cart_item.quantity
    end
    @cart_items_price = ary.sum
  
    @total_price = @shipping_cost + @cart_items_price
    @address_type = params[:order][:address_type]
  
    case @address_type
    when "customer_address"
      @selected_address = current_customer.post_code + " " + current_customer.address + " " + current_customer.last_name + current_member.last_name
    when "registered_address"
      unless params[:order][:registered_address_id] == ""
        selected = Address.find(params[:order][:registered_address_id])
        @selected_address = selected.postal_code + " " + selected.address + " " + selected.name
      else
        render :new
      end
    when "new_address"
      unless params[:order][:new_postal_code] == "" && params[:order][:new_address] == "" && params[:order][:new_name] == ""
        @selected_address = params[:order][:new_postal_code] + " " + params[:order][:new_address] + " " + params[:order][:new_name]
      else
        render :new
      end
    end
  end

  def thanks
    #特に記述なし
  end

  def create
  end

  def index
  end

  def show
  end
end
