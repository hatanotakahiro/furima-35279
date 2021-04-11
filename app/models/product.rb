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
    validates :image
    validates :title, length: { maximum: 40, message: "は40文字以内でお願いします。" }
    validates :text, length: { maximum: 1000, message: "は1000文字以内でお願いします。"  }
    with_options numericality: { other_than: 0, message: "はどれか一つ選んで下さい" } do
      validates :category_id
      validates :status_id
      validates :ship_pay_id
      validates :area_id
      validates :delivery_day_id
    end
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "は300〜9999999円内でお願いします" },
     format: { with: /\A[0-9]+\z/, message:"は半角英数字でお願いします" }
  end
end
