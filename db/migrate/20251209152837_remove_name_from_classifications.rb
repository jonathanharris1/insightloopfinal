class RemoveNameFromClassifications < ActiveRecord::Migration[7.1]
  def change
    remove_column :classifications, :name, :string
  end
end
