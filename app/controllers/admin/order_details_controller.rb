class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!


  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_detail.update(order_detail_params)


    if @order_detail.making_status == "製作中"
      @order.update(status: "製作中")
    end

    if @order.order_details.all?{|order_detail| order_detail.making_status == "製作完了" }
      @order.update(status: "発送準備中" )
    else
      @order.update(status: "製作中")
    end

    flash[:notice] = "更新に成功しました。"
    redirect_to admin_order_path(@order_detail.order.id)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end


end