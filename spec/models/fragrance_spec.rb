require 'rails_helper'

RSpec.describe Fragrance, type: :model do
  describe 'basic functionality' do
    it 'can be created' do
      fragrance = Fragrance.new(name: 'Test Fragrance')
      expect(fragrance.name).to eq('Test Fragrance')
    end
  end
end
