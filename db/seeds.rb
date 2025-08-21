# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

#香水のタグ
puts "タグデータを作成中..."

fragrance_categories = [
  "フローラル", "シトラス", "フルーティ", "ウッディ",
  "スパイシー", "オリエンタル", "マリン", "グリーン"
]

fragrance_categories.each do |category|
  Tag.find_or_create_by(name: category)
end

puts "タグデータ作成完了: #{Tag.count}件"
