class OrderDeliver
  # formオブジェクトパターン
  include ActiveModel::Model
  attr_accessor :token, :postal_code, :area_id, :city, :number, :building, :phone, :order_id, :user_id, :product_id

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :number
    validates :phone

    validates :product_id
    validates :user_id

    validates :token
  end
  validates :area_id, numericality: {other_than: 0, message: "can't be blank"}

  def save
    order = Order.create(user_id: user_id, product_id: product_id)
    # 住所を保存する
    # order_idには、変数orderのidと指定する
    Deliver.create(postal_code: postal_code, area_id: area_id, city: city, number: number, building: building, phone: phone, order_id: order.id)
  end

end
