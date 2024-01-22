class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])

    if @order_detail.update(order_detail_params)
      redirect_to admin_order_path(@order_detail.order), notice: "製作ステータスが更新されました。"
    else
      render :edit  # 更新に失敗した場合の処理を追加
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end
end