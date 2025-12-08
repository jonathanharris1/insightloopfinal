class CreateConversations < ActiveRecord::Migration[7.1]
  def change
    create_table :conversations do |t|
      t.references :user, null: false, foreign_key: true
      t.text :channel
      t.text :content
      t.references :classification, foreign_key: true

      t.timestamps
    end
  end
end
