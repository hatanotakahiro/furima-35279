class Product < ApplicationRecord

  belongs_to :user
  has_one_attached :image
  has_one :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :area
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :ship_pay
  belongs_to_active_hash :delivery_day
  
  with_options  presence: true do  
    validates :title
    validates :text
    validates :category_id
    validates :status_id
    validates :ship_pay_id
    validates :area_id
    validates :delivery_day_id
    validates :price
  end
end
