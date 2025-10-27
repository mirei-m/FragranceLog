require 'rails_helper'

RSpec.describe Calendar, type: :model do
  describe '正常系' do
    it '設定したすべてのバリデーションが機能しているか' do
      user = create(:user)
      fragrance = create(:fragrance)
      calendar = build(:calendar, user: user, fragrance: fragrance)
      expect(calendar).to be_valid
      expect(calendar.errors).to be_empty
    end
  end

  describe 'バリデーションテスト' do
    describe 'start_timeについて' do
      it 'start_timeが存在する場合は有効であること' do
        calendar = build(:calendar)
        expect(calendar).to be_valid
      end

      it 'start_timeが空の場合は無効であること' do
        calendar = build(:calendar, start_time: nil)
        expect(calendar).to be_invalid
      end
    end

    describe 'memoについて' do
      it 'memoが空でも有効であること' do
        calendar = build(:calendar, :without_memo)
        expect(calendar).to be_valid
      end

      it 'memoが1000文字の場合は有効であること' do
        calendar = build(:calendar, :long_memo)
        expect(calendar).to be_valid
      end

      it 'memoが1001文字の場合は無効であること' do
        calendar = build(:calendar, :too_long_memo)
        expect(calendar).to be_invalid
        expect(calendar.errors[:memo]).to include('は1000文字以内で入力してください')
      end
    end

    describe 'weatherについて' do
      it 'weatherが空でも有効であること' do
        calendar = build(:calendar, :without_weather)
        expect(calendar).to be_valid
      end

      it 'weatherが有効な値の場合は有効であること' do
        calendar = build(:calendar, weather: :sunny)
        expect(calendar).to be_valid
      end
    end

    describe 'moodについて' do
      it 'moodが空でも有効であること' do
        calendar = build(:calendar, :without_mood)
        expect(calendar).to be_valid
      end

      it 'moodが有効な値の場合は有効であること' do
        calendar = build(:calendar, mood: :happy)
        expect(calendar).to be_valid
      end
    end
  end

  describe '一意性制約について' do
    it '同じユーザーが同じ日時に複数の記録を作成できないこと' do
      user = create(:user)
      fragrance1 = create(:fragrance)
      fragrance2 = create(:fragrance)
      start_time = Time.current

      create(:calendar, user: user, fragrance: fragrance1, start_time: start_time)
      calendar2 = build(:calendar, user: user, fragrance: fragrance2, start_time: start_time)

      expect(calendar2).to be_invalid
      expect(calendar2.errors[:user_id]).to include('この日はすでに記録があります')
    end

    it '異なるユーザーが同じ日時に記録を作成できること' do
      user1 = create(:user)
      user2 = create(:user)
      fragrance = create(:fragrance)
      start_time = Time.current

      create(:calendar, user: user1, fragrance: fragrance, start_time: start_time)
      calendar2 = build(:calendar, user: user2, fragrance: fragrance, start_time: start_time)

      expect(calendar2).to be_valid
    end

    it '同じユーザーが異なる日時に記録を作成できること' do
      user = create(:user)
      fragrance = create(:fragrance)

      create(:calendar, user: user, fragrance: fragrance, start_time: Time.current)
      calendar2 = build(:calendar, user: user, fragrance: fragrance, start_time: 1.day.from_now)

      expect(calendar2).to be_valid
    end
  end

  describe 'アソシエーションテスト' do
    it { should belong_to(:user) }
    it { should belong_to(:fragrance) }
  end
end
