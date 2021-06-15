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

    it 'has a not unique day' do
      item = create :item, user: user
      expect(item).to be_valid
      item_repeated_day = build :item, user: user, day: item.day
      expect(item_repeated_day).not_to be_valid
      expect(item_repeated_day.errors[:day]).to include('has already been taken')
    end
  end
end
