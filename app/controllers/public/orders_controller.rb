class Public::OrdersController < ApplicationController
  # アクセス権限
  #before_action :authenticate_customer!
  
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
    
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
      @selected_address = current_customer.post_code + " " + current_customer.address + " " + current_customer.last_name + current_customer.last_name
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
  end

  def create
    @order = Order.new
      @order.customer_id = current_customer.id
      @order.shipping_cost = 800
      @cart_items = CartItem.where(customer_id: current_customer.id)
      ary = []
      @cart_items.each do |cart_item|
        ary << cart_item.item.price*cart_item.amount
      end
      @cart_items_price = ary.sum
      @order.total_payment = @order.shipping_cost + @cart_items_price
      @order.payment_method = params[:order][:payment_method]
      if @order.payment_method == "credit_card"
        @order.status = 1
      else
        @order.status = 0
      end
      
      address_type = params[:order][:address_type]
      case address_type
      when "customer_address"
        @order.postal_code = current_customer.postal_code
        @order.address = current_customer.address
        @order.name = current_customer.last_name + current_member.last_name
      when "registered_address"
        Address.find(params[:order][:registered_address_id])
        selected = Addresse.find(params[:order][:registered_address_id])
        @order.postal_code = selected.postal_code
        @order.address = selected.address
        @order.name = selected.name
      when "new_address"
        @order.postal_code = params[:order][:new_postal_code]
        @order.address = params[:order][:new_address]
        @order.name = params[:order][:new_name]
      end
      
      if @order.save
        if @order.status == 0
          @cart_items.each do |cart_item|
            OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, quantity: cart_item.quantity, making_status: 0)
          end
        else
          @cart_items.each do |cart_item|
            OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, quantity: cart_item.quantity, making_status: 1)
          end
        end
        @cart_items.destroy_all
        redirect_to complete_orders_path
      else
        render :items
      end
  end

  def index
    @orders = current_customer.orders.all
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end

  def show
    @order = Order.find(params[:id])
    
  end
  
  private
  def order_params
    params.require(:order).permit(:payment_method)
  end
end
