class Public::OrdersController < ApplicationController
  # アクセス権限
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id

    # 注文情報の計算
    @order.shipping_cost = 800
    @cart_items_price = CartItem.cart_items_total_price(@cart_items) 
    @order.total_payment = @order.shipping_cost + @cart_items_price 
    
    

    case params[:order][:address_type]
    when "customer_address"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    when "registered_address"
      @address = Address.find(params[:order][:registered_address_id])
      @selected_address = @address.address_display
      @address = Address.find(params[:order][:registered_address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    when "new_address"
      @selected_address = "#{params[:order][:new_postal_code]} #{params[:order][:new_address]} #{params[:order][:new_name]}"
       @order.postal_code = params[:order][:new_postal_code]
      @order.address = params[:order][:new_address]
      @order.name = params[:order][:new_name]
    end

  end

  def thanks
    
  end

  def create
  @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.amount = cart_item.amount
      @order_detail.price = cart_item.item.add_tax_price
      @order_detail.save
    end
    
    current_customer.cart_items.destroy_all
    redirect_to orders_thanks_path
  end
  
  def show
     @order = Order.find(params[:id])
     @order_details = @order.order_details
     @order_items = @order.order_details.all
  end

  def index
    @orders = Order.all
    @orders = current_customer.orders.all
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method)
  end

end
