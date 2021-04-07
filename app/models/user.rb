class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products
  has_many :orders

  # 半角英数字両方含むバリデーション
  validates :password, format: { with: /([0-9].*[a-zA-Z]|[a-zA-Z].*[0-9])/, message: '半角英数混合でお願いします' }

  validates :nickname, presence: true
  # 全角（ひらがな、カタカナ、漢字）であるかのバリデーション
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'は全角（漢字、ひらがな、カタカナ）で入力して下さい。'}
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'は全角（漢字、ひらがな、カタカナ）で入力して下さい。'}
  # カタカナであるかのバリデーション
  validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :birth_date, presence: true
end