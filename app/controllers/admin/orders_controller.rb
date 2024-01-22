class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_status = @order.status
    @order_details = @order.order_details
    I18n.locale = :ja
  end

  def update
    @order_detail = OrderDetail.find(params[:id])
    if @order_detail.update(order_detail_params)
      redirect_to admin_order_path(@order_detail.order), notice: "製作ステータスが更新されました。"
    else
      render :show
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end
  def order_params
  params.require(:order).permit(:name, :total_payment, :payment_method, :postal_code, :address, :status)
  end
end
