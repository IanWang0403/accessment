# spec/controllers/reservations_controller_spec.rb
require 'rails_helper'

RSpec.describe Webhooks::ReservationsController, type: :controller do
  describe '#webhook' do
    before do
      Sidekiq::Testing.fake!
    end

    let(:payload) do
      JSON.parse(File.read(Rails.root.join('spec/fixtures/webhooks/payload1.json'))).deep_transform_values! do |value|
        value.is_a?(Integer) ? value.to_s : value
      end
    end

    it 'creates a WebhookEvent and enqueues a ReservationWorker job' do
      expect {
        post :webhook, params: { event_type: 'reservation.created', payload: payload }
      }.to change(WebhookEvent, :count).by(1)
        .and change(ReservationWorker.jobs, :size).by(1)

      event = WebhookEvent.last
      expect(event.event_type).to eq('reservation.created')
      expect(event.payload.deep_stringify_keys).to eq(payload)
    end

    it 'responds with :ok status' do
      post :webhook, params: { event_type: 'reservation.created', payload: payload }
      expect(response).to have_http_status(:ok)
    end
  end
end
