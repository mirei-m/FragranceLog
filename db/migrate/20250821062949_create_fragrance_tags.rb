class CreateFragranceTags < ActiveRecord::Migration[7.2]
  def change
    create_table :fragrance_tags do |t|
      t.references :fragrance, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end

    add_index :fragrance_tags, [:fragrance_id, :tag_id], unique: true
  end
end
