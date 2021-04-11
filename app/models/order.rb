class Order < ApplicationRecord
  attr_accessor :token
  belongs_to :product
  belongs_to :user
  has_one :send
end
