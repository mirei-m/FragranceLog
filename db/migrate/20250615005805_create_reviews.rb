class CreateReviews < ActiveRecord::Migration[7.2]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :fragrance, null: false, foreign_key: true
      t.text :body, null: false

      t.timestamps
    end
  end
end
