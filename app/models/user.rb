class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
        #  :recoverable, :rememberable, :validatable
  has_many :events
  has_many :news

  validates :account, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, length: { within: Devise.password_length }
end
