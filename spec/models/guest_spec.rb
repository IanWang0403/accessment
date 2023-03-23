require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe 'associations' do
    it { should have_many(:reservations) }
  end

  describe 'validations' do
    subject { build(:guest) }

    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end

  describe 'creating a guest' do
    context 'with valid attributes' do
      let(:guest) { build(:guest) }

      it 'creates a new guest' do
        expect { guest.save }.to change(Guest, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_guest) { build(:guest, email: nil, phone: nil) }

      it 'does not create a new guest' do
        expect { invalid_guest.save }.to_not change(Guest, :count)
      end
    end

    it 'validates the format of the email' do
      valid_emails = [
        'test@example.com',
        'john.doe@example.co.uk',
        'user+tag@example.org'
      ]
      invalid_emails = [
        'example.com',
        'user@example@com'
      ]

      valid_emails.each do |email|
        guest = build(:guest, email: email)
        expect(guest).to be_valid, "expected '#{email}' to be valid"
      end

      invalid_emails.each do |email|
        guest = build(:guest, email: email)
        expect(guest).to be_invalid, "expected '#{email}' to be invalid"
      end
    end
  end
end