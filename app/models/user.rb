class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :carts

  def current_cart=(cart)
    self.current_cart_id = cart.id if cart.try(:id)
    self.save
  end

  def current_cart
    Cart.find(self.current_cart_id) if self.current_cart_id
  end
end
