class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :check_address_input, only: [:confirm]

  def new
    @order = Order.new
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id

    @order.shipping_cost = 800
    
    @cart_items_price = 0
    @cart_items.each do |cart_item|
      @cart_items_price += cart_item.item.add_tax_price * cart_item.amount
    end

    @order.total_payment = @order.shipping_cost + @cart_items_price

    case params[:order][:address_type]
    when "customer_address"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    when "registered_address"
      @address = Address.find(params[:order][:registered_address_id])
      @selected_address = @address.address_display
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

    if @order.save
      current_customer.cart_items.each do |cart_item|
        @order_detail = @order.order_details.new(
          item_id: cart_item.item_id,
          amount: cart_item.amount,
          price: cart_item.item.add_tax_price
        )
        @order_detail.save
      end
      current_customer.cart_items.destroy_all
      redirect_to orders_thanks_path
    else
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @cart_items_price = 0
    @order_details.each do |order_detail|
      @cart_items_price += order_detail.item.add_tax_price * order_detail.amount
    end
  end

  def index
    @orders = current_customer.orders.all
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method)
  end

  def check_address_input
    if params[:order][:address_type] == "new_address" &&
       (params[:order][:new_postal_code].blank? ||
        params[:order][:new_address].blank? ||
        params[:order][:new_name].blank?)
      flash[:alert] = "新しいお届け先の情報を入力してください"
      redirect_to new_order_path
    elsif params[:order][:address_type] == "registered_address" &&
          params[:order][:registered_address_id].blank?
      flash[:alert] = "登録済みの住所を選択してください"
      redirect_to new_order_path
    end
  end
end
