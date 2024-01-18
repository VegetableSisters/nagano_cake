class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_my_page_path(current_customer)
    else
      render :customers_information_edit
  end
  end

  def confirm
    # 顧客の退会確認画面　/customers/confirm
  end

  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.update(is_deleted: false)
    reset_session
    flash[:notice] = "退会処理が完了しました"
    redirect_to root_path
  end
  
  private
  def customer_params
    params.require(:customer).permit(:email,:last_name,:first_name,:last_name_kana,:first_name_kana,:postal_code,:address,:telephone_number )
  end
end
