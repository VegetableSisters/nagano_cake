
    #注文商品に対してupdate_allを使用して、making_statusで()の中に
    #どういう時に１５行目から~~update_all~~ if @order.status =="confirmed(yml確認）"　更新したらredirect_to

class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order.update(status: params[:order][:status])
    @order_details = @order.order_details
    #@order_details.update(making_status:"waiting_for_production")

    if params[:order][:status] == "入金確認"
       @order_details.update_all(making_status:"製作待ち")
    end

    flash[:notice] = "更新に成功しました。"
    redirect_to admin_order_path(@order)


  end
  
  def index
    @user = current_user
    @orders = @user.orders.order(created_at: :desc)
  end

  private

  def order_params
    params.require(:order).permit(:customer_id,:name, :poastal_code, :address)
  end

end
