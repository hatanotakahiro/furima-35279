require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#create' do
    before do
      @product = FactoryBot.build(:product)
    end

    context '登録できる場合' do
      it '商品出品情報が揃っていれば登録できること' do
        expect(@product).to be_valid
      end
    end
    
    context '登録できない場合' do
      it 'titleが空では登録できないこと' do
        @product.title = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Title can't be blank")
      end
      it 'titleが40文字以上であれば登録できないこと' do
        @product.title = Faker::Lorem.characters(number: 41)
        @product.valid?
        expect(@product.errors.full_messages).to include("Title は40文字以内でお願いします。")
      end
      it 'textが空では登録できないこと' do
        @product.text = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Text can't be blank")
      end
      it 'category_idが空では登録できないこと' do
        @product.category_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Category はどれか一つ選んで下さい")
      end
      it 'category_idが0では登録できないこと' do
        @product.category_id = 0
        @product.valid?
        expect(@product.errors.full_messages).to include("Category はどれか一つ選んで下さい")
      end
      it 'status_idが空では登録できないこと' do
        @product.status_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Status はどれか一つ選んで下さい")
      end
      it 'status_idが0では登録できないこと' do
        @product.status_id = 0
        @product.valid?
        expect(@product.errors.full_messages).to include("Status はどれか一つ選んで下さい")
      end
      it 'ship_pay_idが空では登録できないこと' do
        @product.ship_pay_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Ship pay はどれか一つ選んで下さい")
      end
      it 'ship_pay_idが0では登録できないこと' do
        @product.ship_pay_id = 0
        @product.valid?
        expect(@product.errors.full_messages).to include("Ship pay はどれか一つ選んで下さい")
      end
      it 'area_idが空では登録できないこと' do
        @product.area_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Area はどれか一つ選んで下さい")
      end
      it 'area_idが0では登録できないこと' do
        @product.area_id = 0
        @product.valid?
        expect(@product.errors.full_messages).to include("Area はどれか一つ選んで下さい")
      end
      it 'delivery_day_idが空では登録できないこと' do
        @product.delivery_day_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Delivery day はどれか一つ選んで下さい")
      end
      it 'delivery_day_idが0では登録できないこと' do
        @product.delivery_day_id = 0
        @product.valid?
        expect(@product.errors.full_messages).to include("Delivery day はどれか一つ選んで下さい")
      end
      it 'priceが空では登録できないこと' do
        @product.price = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Price can't be blank", "Price は300〜9999999円内でお願いします", "Price は半角英数字でお願いします")
      end
      it 'priceが半角数字以外では登録できないこと' do
        @product.price = "a"
        @product.valid?
        expect(@product.errors.full_messages).to include("Price は300〜9999999円内でお願いします")
      end
      it 'priceが300未満では登録できないこと' do
        @product.price = 299
        @product.valid?
        expect(@product.errors.full_messages).to include("Price は300〜9999999円内でお願いします")
      end
      it 'priceが10000000以上では登録できないこと' do
        @product.price = 10000000
        @product.valid?
        expect(@product.errors.full_messages).to include("Price は300〜9999999円内でお願いします")
      end
      it 'userが紐付いていないと保存できないこと' do
        @product.user = nil
        @product.valid?
        expect(@product.errors.full_messages).to include('User must exist')
      end
      it 'imageが空では登録できないこと' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Image can't be blank")
      end
    end
  end
end