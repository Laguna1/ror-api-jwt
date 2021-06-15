require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    let(:user) { create :user }

    it 'has a valid factory' do
      item = build :item, user: user
      expect(item).to be_valid
      item.save!
      another_item = build :item, user: user
      expect(another_item).to be_valid
    end

    it 'has an invalid day' do
      item = build :item, user: user, day: ''
      expect(item).not_to be_valid
      expect(item.errors[:day]).to include("can't be blank")
    end
  end
end
