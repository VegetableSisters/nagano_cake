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
    @order.payment_method = params[:order][:payment_method]
    @total_payment = CartItem.cart_items_total_price(@cart_items)
    @order.shipping_cost = 800

    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name_a
      render 'confirm'
    elsif params[:order][:address_option] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
      render 'confirm'
    elsif params[:order][:address_option] == "2"
      @address = current_customer.addresses.new
      @address.address = params[:order][:address]
      @address.name = params[:order][:name]
      @address.postal_code = params[:order][:postal_code]
      @address.customer_id = current_customer.id
      if @address.save
      @order.postal_code = @address.postal_code
      @order.name = @address.name
      @order.address = @address.address
      else
       render 'new'
      end
    end
  end

  def thanks
    redirect_to thanks_orders_path
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
        @order.name = current_customer.last_name + current_customer.first_name
      when "registered_address"
        @order.registered_address = Address.find(params[:order][:registered_address_id])
  @order.postal_code = @order.registered_address.postal_code
  @order.address = @order.registered_address.address
  @order.name = @order.registered_address.name
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
    if params[:id] == "confirm"
    flash[:error] = "無効な注文IDです。"
    redirect_to orders_path
  else
    @order = Order.find(params[:id])
  end
    
  end
  
  private
  def order_params
    params.require(:order).permit(:payment_method, :address_type, :new_postal_code, :new_address, :new_name)
  end
  
  
end
