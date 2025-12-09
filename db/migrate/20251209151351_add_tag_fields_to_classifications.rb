class AddTagFieldsToClassifications < ActiveRecord::Migration[7.1]
  def change
    add_column :classifications, :tag, :string
    add_column :classifications, :tag_description, :text
  end
end
