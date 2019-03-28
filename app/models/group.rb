class Group < ApplicationRecord
  # has_and_belongs_to_many :users
  has_many :members, :dependent => :delete_all
  has_many :users , through: :members , :dependent => :delete_all
  belongs_to :user
end
