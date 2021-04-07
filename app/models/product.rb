class Product < ApplicationRecord

  belongs_to :user
  has_one_attached :image
  has_one :order

  validates :title, presence: true
  validates :text, presence: true
  validates :category_id, presence: true
  validates :status_id, presence: true
  validates :ship_pay_id, presence: true
  validates :area_id, presence: true
  validates :delivery_day_id, presence: true
  validates :price, presence: true
end
