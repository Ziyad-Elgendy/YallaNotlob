class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# belongs_to :user
# has_many :users
has_many :notifications
has_and_belongs_to_many :orders
has_and_belongs_to_many :groups


end
