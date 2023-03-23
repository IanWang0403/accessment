class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :reservation_code, null: false, index: { unique: true }
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :nights, null: false
      t.references :guest, null: false, foreign_key: true
      t.integer :guests, null: false
      t.integer :adults, null: false
      t.integer :children, null: false
      t.integer :infants, null: false
      t.string :status, null: false
      t.string :currency, null: false
      t.money :payout_price, null: false
      t.money :security_price, null: false
      t.money :total_price, null: false
      t.timestamps
    end
  end
end