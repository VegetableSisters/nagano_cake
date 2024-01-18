class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :addresses, dependent: :destroy

  def active_for_authentication?
    super && (is_deleted == true)
  end

  def full_name
    self.last_name + "" + self.first_name
  end

  end
