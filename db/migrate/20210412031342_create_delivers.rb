class CreateDelivers < ActiveRecord::Migration[6.0]
  def change
    create_table :delivers do |t|
      t.string :postal_code,  null: false
      t.integer :area_id,     null: false
      t.string :city,         null: false
      t.string :number,       null: false
      t.string :building
      t.string :phone,        null: false
      t.references :order, foreign_key: true
      t.timestamps
    end
  end
end