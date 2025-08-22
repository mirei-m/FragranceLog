class CreateFavorites < ActiveRecord::Migration[7.2]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :review, null: false, foreign_key: true

      t.timestamps
    end

    # 同じユーザーが同じレビューを複数回お気に入りできないように
    add_index :favorites, [ :user_id, :review_id ], unique: true
  end
end
