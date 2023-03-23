require 'rails_helper'

RSpec.describe ReservationAdapter, type: :adapter do
  describe '.adapt' do
    let(:payload1) { JSON.parse(File.read(Rails.root.join('spec/fixtures/webhooks/payload1.json'))) }
    let(:payload2) { JSON.parse(File.read(Rails.root.join('spec/fixtures/webhooks/payload2.json'))) }

    context 'when payload1 is given' do
      let(:adapted_response) { ReservationAdapter.adapt(payload1) }

      it 'returns the expected reservation attributes' do
        expect(adapted_response[:reservation]).to include(
          reservation_code: 'XXX12345678',
          start_date: '2021-03-12',
          end_date: '2021-03-16',
          nights: 4,
          guests: 4,
          adults: 2,
          children: 2,
          infants: 0,
          status: 'accepted',
          currency: 'AUD',
          payout_price: '3800.00',
          security_price: '500.00',
          total_price: '4300.00'
        )
      end

      it 'returns the expected guest attributes' do
        expect(adapted_response[:guest]).to include(
          first_name: 'Wayne',
          last_name: 'Woodbridge',
          email: 'wayne_woodbridge@bnb.com',
          phone: ['639123456789', '639123456789']
        )
      end
    end

    context 'when payload2 is given' do
      let(:adapted_response) { ReservationAdapter.adapt(payload2) }

      it 'returns the expected reservation attributes' do
        expect(adapted_response[:reservation]).to include(
          reservation_code: 'YYY12345678',
          start_date: '2021-04-14',
          end_date: '2021-04-18',
          nights: 4,
          guests: 4,
          adults: 2,
          children: 2,
          infants: 0,
          status: 'accepted',
          currency: 'AUD',
          payout_price: '4200.00',
          security_price: '500.00',
          total_price: '4700.00'
        )
      end

      it 'returns the expected guest attributes' do
        expect(adapted_response[:guest]).to include(
          first_name: 'Wayne',
          last_name: 'Woodbridge',
          email: 'wayne_woodbridge@bnb.com',
          phone: ['639123456789']
        )
      end
    end
  end
end
