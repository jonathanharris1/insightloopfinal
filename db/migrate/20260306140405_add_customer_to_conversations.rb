class AddCustomerToConversations < ActiveRecord::Migration[7.1]
  def change
    add_reference :conversations, :customer, foreign_key: true
  end
end
