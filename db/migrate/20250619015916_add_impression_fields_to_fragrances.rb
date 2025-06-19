class AddImpressionFieldsToFragrances < ActiveRecord::Migration[7.2]
  def change
    add_column :fragrances, :sweetness, :integer
    add_column :fragrances, :freshness, :integer
    add_column :fragrances, :floral, :integer
    add_column :fragrances, :calm, :integer
    add_column :fragrances, :sexy, :integer
    add_column :fragrances, :spicy, :integer
  end
end
