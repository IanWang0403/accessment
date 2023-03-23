require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'associations' do
    it { should belong_to(:guest) }
  end

  describe 'validations' do
    subject { create(:reservation) }

    it { should validate_presence_of(:reservation_code) }
    it { should validate_uniqueness_of(:reservation_code) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:nights) }
    it { should validate_presence_of(:guests) }
    it { should validate_presence_of(:adults) }
    it { should validate_presence_of(:children) }
    it { should validate_presence_of(:infants) }
    it { should validate_presence_of(:status) }
  end
end