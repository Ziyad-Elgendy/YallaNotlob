class Friend < ApplicationRecord
    belongs_to :user
    has_many :users
    belongs_to :friend, :class_name => "User"
end
