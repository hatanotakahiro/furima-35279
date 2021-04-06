# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique:true |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birth_date         | date   | null: false |

### Association

- has_many :product
- has_many :orders


## products テーブル

| Column          | Type       | Options     |
| --------------- | ---------- | ----------- |
| title           | string     | null: false |
| text            | text       | null: false |
| category_id     | integer    | null: false |
| status_id       | integer    | null: false |
| ship_pay_id     | integer    | null: false |
| ship_area_id    | integer    | null: false |
| delivery_day_id | integer    | null: false |
| price           | integer    | null: false |
| user            | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order


## orders テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| product   | references | null: false, foreign_key: true |

### Association

- belongs_to :product
- belongs_to :user
- has_one :send


## sends テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| postal_code | string     | null: false |
| state_id    | integer    | null: false |
| city        | string     | null: false |
| number      | string     | null: false |
| building    | string     | null: true  |
| phone       | string     | null: false |
| order       | references | null: false, foreign_key: true |

### Association

- belongs_to :order