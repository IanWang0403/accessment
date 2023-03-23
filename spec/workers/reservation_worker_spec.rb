require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe ReservationWorker, type: :worker do
  describe '#perform' do
    before do
      Sidekiq::Testing.inline!
    end

    let(:event) { create(:webhook_event, payload: JSON.parse(File.read(Rails.root.join('spec/fixtures/webhooks/payload1.json')))) }
    let(:reservation_service_instance) { instance_double(ReservationService) }

    it 'calls the ReservationService with the payload from the WebhookEvent' do
      allow(ReservationService).to receive(:new).with(event.payload).and_return(reservation_service_instance)
      allow(reservation_service_instance).to receive(:call)

      ReservationWorker.new.perform(event.id)

      expect(ReservationService).to have_received(:new).with(event.payload)
      expect(reservation_service_instance).to have_received(:call)
    end
  end
end