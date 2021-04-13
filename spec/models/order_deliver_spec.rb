require 'rails_helper'

RSpec.describe OrderDeliver, type: :model do
  describe '商品配送情報の保存' do
    before do
      user = FactoryBot.create(:user)
      @product = FactoryBot.create(:product)
      @order_deliver = FactoryBot.build(:order_deliver, user_id: user.id, product_id: @product.id)
    end
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_deliver).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @order_deliver.building = ''
        expect(@order_deliver).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it "tokenが空では登録できないこと" do
        @order_deliver.token = nil
        @order_deliver.valid?
        expect(@order_deliver.errors.full_messages).to include("Token can't be blank")
      end
      it "userが紐づいてないと登録できないこと" do
        @order_deliver.user_id = ""
        @order_deliver.valid?
        expect(@order_deliver.errors.full_messages).to include("User can't be blank")
      end
      it "productが紐づいてないと登録できないこと" do
        @order_deliver.product_id = ""
        @order_deliver.valid?
        expect(@order_deliver.errors.full_messages).to include("Product can't be blank")
      end
      it 'postal_codeが空だと保存できないこと' do
        @order_deliver.postal_code = ''
        @order_deliver.valid?
        expect(@order_deliver.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_deliver.postal_code = '1234567'
        @order_deliver.valid?
        expect(@order_deliver.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'area_idを選択していないと保存できないこと' do
        @order_deliver.area_id = 0
        @order_deliver.valid?
        expect(@order_deliver.errors.full_messages).to include("Area can't be blank")
      end
      it 'cityは空が空だと保存できないこと' do
        @order_deliver.city = ''
        @order_deliver.valid?
        expect(@order_deliver.errors.full_messages).to include("City can't be blank")
      end
      it 'numberが空だと保存できないこと' do
        @order_deliver.number = ''
        @order_deliver.valid?
        expect(@order_deliver.errors.full_messages).to include("Number can't be blank")
      end
      it 'phoneが空だと保存できないこと' do
        @order_deliver.phone = ''
        @order_deliver.valid?
        expect(@order_deliver.errors.full_messages).to include("Phone can't be blank")
      end
      it 'phoneが英数字混合だと保存できないこと' do
        @order_deliver.phone = '090a7b7c7d'
        @order_deliver.valid?
        expect(@order_deliver.errors.full_messages).to include("Phone は11桁の半角数字でお願いします")
      end
      it 'phoneが11桁でないと保存できないこと' do
        @order_deliver.phone = '0904747474'
        @order_deliver.valid?
        expect(@order_deliver.errors.full_messages).to include("Phone は11桁の半角数字でお願いします")
      end
      it 'priceが空だと保存できないこと' do
        @product.price = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが全角数字だと保存できないこと' do
        @product.price = '２０００'
        @product.valid?
        expect(@product.errors.full_messages).to include('Price は300〜9999999円内でお願いします')
      end
      it 'priceが1円未満では保存できないこと' do
        @product.price = 0
        @product.valid?
        expect(@product.errors.full_messages).to include('Price は300〜9999999円内でお願いします')
      end
      it 'priceが1,000,000円を超過すると保存できないこと' do
        @product.price = 10000000
        @product.valid?
        expect(@product.errors.full_messages).to include('Price は300〜9999999円内でお願いします')
      end
    end
  end
end

# with_options presence: true do




#   validates :phone, format: {with: /\A\d{11}\z/, message: "は11桁の半角数字でお願いします"}
# end
# validates :area_id, numericality: {other_than: 0, message: "can't be blank"}
