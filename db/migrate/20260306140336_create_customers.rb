class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :external_id, null: false
      t.string :name
      t.string :email
      t.decimal :mrr, precision: 10, scale: 2
      t.string :plan
      t.string :status, null: false, default: "active"
      t.date :churned_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :customers, :external_id, unique: true
  end
end
