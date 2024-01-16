class Admin::HomesController < ApplicationController
  # アクセス権限
  before_action :authenticate_admin!
  
  def top
  end
end
