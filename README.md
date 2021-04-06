# テーブル設計

## users テーブル

| Column            | Type   | Options     |
| ----------------- | ------ | ----------- |
| nickname          | string | null: false |
| email             | string | null: false |
| password          | string | null: false |
| last_name         | string | null: false |
| first_name        | string | null: false |
| last_name_kana    | string | null: false |
| first_name_kana   | string | null: false |
| birth_date        | date   | null: false |

### Association

- has_many :product
- has_many :orders


## products テーブル

| Column       | Type       | Options     |
| ------------ | ---------- | ----------- |
| image        |            |             |
| title        | string     | null: false |
| text         | text       | null: false |
| category     | string     | null: false |
| status       | string     | null: false |
| ship_pay     | string     | null: false |
| ship_area    | string     | null: false |
| delivery_day | string     | null: false |
| price        | integer    | null: false |
| user         | references | null: false, foreign_key: true |

### Association

- belongs_to :users
- has_one :orders
- has_one :sends


## orders テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| product   | references | null: false, foreign_key: true |

### Association

- belongs_to :product
- belongs_to :user


## sends テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| postal    | string     | null: false |
| state     | text       | null: false |
| city      | string     | null: false |
| number    | string     | null: false |
| building  | string     | null: true  |
| phone     | string     | null: false |
| product   | references | null: false, foreign_key: true |

### Association

- belongs_to :product