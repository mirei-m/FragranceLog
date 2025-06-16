class AddStatusToFragrances < ActiveRecord::Migration[7.2]
  def change
    add_column :fragrances, :status, :integer, default: 0, null: false
  end
end
