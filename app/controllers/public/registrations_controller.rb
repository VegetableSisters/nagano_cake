# frozen_string_literal: true

class Public::RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters

  # 新規会員登録に必要な情報は、姓名、姓名カナ、Email、郵便番号、住所、電話番号、パスワード
   protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:email,:last_name,:first_name,:last_name_kana,:first_name_kana,:postal_code,:address,:telephone_number])
    end
    
    def after_sign_up_path_for(resource)
        customers_my_page_path
    end
    
  end
