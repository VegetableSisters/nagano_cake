class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  
  def update
  @order_detail = OrderDetail.find(params[:id])

  if @order_detail.update(order_detail_params)
    puts @order_detail.inspect # 追加行
    redirect_to admin_order_path(@order_detail.order), notice: "製作ステータスが更新されました。"
  else
    render :edit
  end
end

  private

  def order_detail_params
  params.require(:order_detail).permit(:shipping_status, :production_status) # shipping_statusの他にproduction_statusも追加
end
end