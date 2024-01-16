class Public::CustomersController < ApplicationController
  # アクセス権限
  # before_action :authenticate_customer!
  
  def show
    # 顧客のマイページ　URL：/customers/my_page　
    @customer = current_customer
  end

  def edit
    # 顧客の登録情報編集画面　/customers/information/edit
    # @customer = current_customer
  end

  def update
    # 顧客の登録情報更新　/customers/information
    # @customer = current_customer
  end

  def confirm
    # 顧客の退会確認画面　/customers/confirm
  end

  def withdraw
    # 顧客の退会処理(ステータスの更新)　/customers/withdraw
  end
end
