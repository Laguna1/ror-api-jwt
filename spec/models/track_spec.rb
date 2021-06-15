require 'rails_helper'

RSpec.describe Track, type: :model do
  describe 'validations' do
    let(:user) { create :user }
    let(:item) { create :item, user: user }

    it 'has a valid factory' do
      track = build :track, item: item
      expect(track).to be_valid
    end

    it 'has an invalid name' do
      track = build :track, item: item, name: ''
      expect(track).not_to be_valid
      expect(track.errors[:name]).to include("can't be blank")
    end

    it 'has an invalid distance' do
      track = build :track, item: item, distance: nil
      expect(track).not_to be_valid
      expect(track.errors[:distance]).to include("can't be blank")
    end

    it 'has an invalid duration' do
      track = build :track, item: item, duration: nil
      expect(track).not_to be_valid
      expect(track.errors[:duration]).to include("can't be blank")
    end

    it 'has an invalid repeat' do
      track = build :track, item: item, repeat: nil
      expect(track).not_to be_valid
      expect(track.errors[:repeat]).to include("can't be blank")
    end
  end
end
