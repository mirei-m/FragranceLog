require 'rails_helper'

RSpec.describe Review, type: :model do
  describe '正常' do
    it '設定したすべてのバリデーションが機能しているか' do
      review = build(:review)
      expect(review).to be_valid
      expect(review.errors).to be_empty
    end
  end

  # バリデーションテスト
  describe 'バリデーションテスト' do
    context 'bodyについて' do
      it 'bodyが存在する場合は有効であること' do
        review = build(:review, body: 'テストレビュー')
        expect(review).to be_valid
      end

      it 'bodyが空の場合は無効であること' do
        review = build(:review, body: '')
        expect(review).to be_invalid
        expect(review.errors[:body]).to include("を入力してください")
      end

      it 'bodyが1000文字の場合は有効であること' do
        review = build(:review, :long_body)
        expect(review).to be_valid
      end

      it 'bodyが1001文字の場合は無効であること' do
        review = build(:review, :too_long_body)
        expect(review).to be_invalid
        expect(review.errors[:body]).to include('は1000文字以内で入力してください')
      end
    end

    context '一意性制約について' do
      let(:user) { create(:user) }
      let(:fragrance) { create(:fragrance) }

      it '同じユーザーが同じ香水に複数のレビューを作成できないこと' do
        create(:review, user: user, fragrance: fragrance)
        duplicate_review = build(:review, user: user, fragrance: fragrance)

        expect(duplicate_review).to be_invalid
        expect(duplicate_review.errors[:fragrance_id]).to include('はすでにレビュー済みです')
      end

      it '異なるユーザーが同じ香水にレビューを作成できること' do
        user2 = create(:user)
        create(:review, user: user, fragrance: fragrance)
        review2 = build(:review, user: user2, fragrance: fragrance)

        expect(review2).to be_valid
      end

      it '同じユーザーが異なる香水にレビューを作成できること' do
        fragrance2 = create(:fragrance)
        create(:review, user: user, fragrance: fragrance)
        review2 = build(:review, user: user, fragrance: fragrance2)

        expect(review2).to be_valid
      end
    end
  end

  # アソシエーションテスト
  describe 'アソシエーションテスト' do
    it { should belong_to(:user) }
    it { should belong_to(:fragrance) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:favorites).dependent(:destroy) }
    it { should have_many(:favorited_users).through(:favorites).source(:user) }
  end
end
