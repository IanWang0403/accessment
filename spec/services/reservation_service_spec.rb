require 'rails_helper'

RSpec.shared_examples "reservation_service_examples" do |payload_file|
  let(:payload) { JSON.parse(File.read(Rails.root.join(payload_file))) }
  let(:service) { ReservationService.new(payload) }
  let(:adapted_response) { ReservationAdapter.adapt(payload) }
  let(:guest) { adapted_response[:guest] }
  let(:reservation) { adapted_response[:reservation] }

  before do
    allow(ReservationAdapter).to receive(:adapt).and_return(adapted_response)
  end

  context 'when the Guest and Reservation do not exist' do
    it 'creates a new Guest' do
      expect { service.call }.to change(Guest, :count).by(1)
    end

    it 'creates a new Reservation' do
      expect { service.call }.to change(Reservation, :count).by(1)
    end
  end

  context 'when the Guest and Reservation already exist' do
    let!(:existing_guest) { Guest.create!(guest) }
    let!(:existing_reservation) { Reservation.create!(reservation.merge(guest_id: existing_guest.id)) }

    it 'does not create a new Guest' do
      expect { service.call }.not_to change(Guest, :count)
    end

    it 'does not create a new Reservation' do
      expect { service.call }.not_to change(Reservation, :count)
    end

    it 'updates the existing Guest' do
      service.call
      existing_guest.reload
      expect(existing_guest.attributes).to include(guest.stringify_keys)
    end

    it 'updates the existing Reservation' do
      service.call
      existing_reservation.reload
    
      updated_attributes = existing_reservation.attributes.merge(
        'start_date' => existing_reservation.start_date.to_s,
        'end_date' => existing_reservation.end_date.to_s,
        'payout_price' => format('%.2f', existing_reservation.payout_price),
        'security_price' => format('%.2f', existing_reservation.security_price),
        'total_price' => format('%.2f', existing_reservation.total_price)
      )
    
      expect(updated_attributes).to include(reservation.merge(guest_id: existing_guest.id).stringify_keys)
    end
  end

  context 'when an error occurs during update' do
    before do
      allow_any_instance_of(Guest).to receive(:update!).and_raise(ActiveRecord::RecordInvalid)
    end

    it 'raises an error and rolls back the transaction' do
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
      expect(Guest.count).to eq(0)
      expect(Reservation.count).to eq(0)
    end
  end
end

RSpec.describe ReservationService, type: :service do
  describe '#call' do
    context 'with payload1' do
      include_examples "reservation_service_examples", 'spec/fixtures/webhooks/payload1.json'
    end

    context 'with payload2' do
      include_examples "reservation_service_examples", 'spec/fixtures/webhooks/payload2.json'
    end
  end
end
