class AddOccurredOnToConversations < ActiveRecord::Migration[7.1]
  def change
    def up
    add_column :conversations, :occurred_on, :date

    # backfill: usa a data do created_at pras conversas que já existem
    execute <<~SQL
      UPDATE conversations
      SET occurred_on = DATE(created_at)
      WHERE occurred_on IS NULL;
    SQL

    # obriga sempre ter occurred_on:
    change_column_null :conversations, :occurred_on, false
    end
  end

  def down
    remove_column :conversations, :occurred_on
  end
end
