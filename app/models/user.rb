class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products
  has_many :orders

  # 半角英数字両方含むバリデーション
  validates :password, format: { with: /([0-9].*[a-zA-Z]|[a-zA-Z].*[0-9])/, message: '半角英数混合でお願いします' }

  with_options  presence: true do  
    validates :nickname
    # 全角（ひらがな、カタカナ、漢字）であるかのバリデーション
    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角（漢字、ひらがな、カタカナ）で入力して下さい。'} do  
      validates :last_name
      validates :first_name
    end
    # カタカナであるかのバリデーション
    with_options format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'} do
      validates :last_name_kana
      validates :first_name_kana
    end
    validates :birth_date
  end
end