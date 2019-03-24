class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


has_many :friends
belongs_to :friend
has_many :inverse_friends, :class_name => "Friend", :foreign_key => "friend_id"
has_many :notifications
has_and_belongs_to_many :orders
has_many :members


end
