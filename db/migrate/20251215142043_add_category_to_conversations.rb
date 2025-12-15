class AddCategoryToConversations < ActiveRecord::Migration[7.1]
  def change
    add_reference :conversations, :category, foreign_key: true
  end
end
