class Public::SessionsController < Devise::SessionsController
  before_action :configure_permitted_parameters
  before_action :reject_customer, only: [:create]

  def after_sign_in_path_for(resource)
    root_path
  end

  # 退会機能（実装ヒントより）
  
  # @customer.valid_password?(params[:customer][:password]) && !@customer.is_deleted
  # @customer.valid_password?(params[:customer][:password]) ＝特定したアカウントのパスワードとログイン画面で入力されたパスワードが一致しているか確認
  # && ＝ かつ
  # !（否定）@customer.is_deleted ＝ is_deletedがfalseか確認＝会員が退会してないか確認 ＝ ログイン可能な状態か確認
  
  # else　flash[:notice] = "項目を入力してください" ＝ パスワードが間違っているか、会員が退会しているときに表示
  
  # reject_customer（カスタム認証メゾット）
  # 会員が入力したEmailから、DB内から対応する会員レコードを取得する
  # 会員レコードが存在する場合は、入力するPasswordが正しいか検証する
  # 入力されたEmailとPasswordが正しくない場合は、エラーメッセージを表示させて、ログインさせない
  # ログインに失敗した場合は、新規登録画面にリダイレクトして、エラーメッセージを表示する
  
    protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password])
    end
  
    def reject_customer
      @customer = Customer.find_by(email: params[:customer][:email])
      if @customer
        if @customer.valid_password?(params[:customer][:password]) && !@customer.is_deleted
          flash[:notice] = "退会済みです"
          redirect_to new_customer_registration_path
        else
          flash[:notice] = "正しい情報を入力してください"
        end
      else
        flash[:notice] = "会員情報が見つからないため、再度会員登録をお願いします"
      end
    end
  end
