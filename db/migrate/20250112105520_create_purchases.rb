class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.string :stripe_session_id
      t.integer :status, default: 0, null: false
      t.integer :quantity, default: 1, null: false
      t.integer :amount_in_cents, default: 0, null: false

      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: { to_table: :courses }

      t.timestamps
    end
  end
end
