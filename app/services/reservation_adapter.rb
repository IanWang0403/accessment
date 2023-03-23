class ReservationAdapter
  def self.adapt(api_response)
    {
      reservation: reservation_attributes(api_response),
      guest: guest_attributes(api_response)
    }
  end

  private

  def self.reservation_attributes(api_response)
    {
      reservation_code: reservation_code(api_response),
      start_date: start_date(api_response),
      end_date: end_date(api_response),
      nights: nights(api_response),
      guests: guests(api_response),
      adults: adults(api_response),
      children: children(api_response),
      infants: infants(api_response),
      status: status(api_response),
      currency: currency(api_response),
      payout_price: payout_price(api_response),
      security_price: security_price(api_response),
      total_price: total_price(api_response)
    }
  end

  def self.guest_attributes(api_response)
    {
      first_name: guest_first_name(api_response),
      last_name: guest_last_name(api_response),
      email: guest_email(api_response),
      phone: guest_phone(api_response)
    }
  end

  # Define private methods to extract data from different JSON structures
  def self.reservation_code(api_response)
    api_response.dig('reservation', 'code') || api_response.dig('reservation_code')
  end

  def self.start_date(api_response)
    api_response.dig('reservation', 'start_date') || api_response.dig('start_date')
  end

  def self.end_date(api_response)
    api_response.dig('reservation', 'end_date') || api_response.dig('end_date')
  end

  def self.nights(api_response)
    api_response.dig('reservation', 'nights') || api_response.dig('nights')
  end

  def self.guests(api_response)
    api_response.dig('reservation', 'number_of_guests') || api_response.dig('guests') || self.adults(api_response) + self.children(api_response) + self.infants(api_response)
  end

  def self.adults(api_response)
    api_response.dig('reservation', 'guest_details', 'number_of_adults') || api_response.dig('adults') || 0
  end

  def self.children(api_response)
    api_response.dig('reservation', 'guest_details', 'number_of_children') || api_response.dig('children') || 0
  end

  def self.infants(api_response)
    api_response.dig('reservation', 'guest_details', 'number_of_infants') || api_response.dig('infants') || 0
  end

  def self.status(api_response)
    api_response.dig('reservation', 'status_type') || api_response.dig('status')
  end

  def self.currency(api_response)
    api_response.dig('reservation', 'host_currency') || api_response.dig('currency')
  end

  def self.payout_price(api_response)
    api_response.dig('reservation', 'expected_payout_amount') || api_response.dig('payout_price')
  end

  def self.security_price(api_response)
    api_response.dig('reservation', 'listing_security_price_accurate') || api_response.dig('security_price')
  end

  def self.total_price(api_response)
    api_response.dig('reservation', 'total_paid_amount_accurate') || api_response.dig('total_price')
  end

  def self.guest_first_name(api_response)
    api_response.dig('reservation', 'guest_first_name') || api_response.dig('guest', 'first_name')
  end

  def self.guest_last_name(api_response)
    api_response.dig('reservation', 'guest_last_name') || api_response.dig('guest', 'last_name')
  end

  def self.guest_email(api_response)
    api_response.dig('reservation', 'guest_email') || api_response.dig('guest', 'email')
  end

  def self.guest_phone(api_response)
    api_response.dig('reservation', 'guest_phone_numbers') || [api_response.dig('guest', 'phone')]
  end
end

# {
#   "reservation": {
#     "code": "XXX12345678",
#     "start_date": "2021-03-12",
#     "end_date": "2021-03-16",
#     "expected_payout_amount": "3800.00",
#     "guest_details": {
#       "localized_description": "4 guests",
#       "number_of_adults": 2,
#       "number_of_children": 2,
#       "number_of_infants": 0
#     },
#     "guest_email": "wayne_woodbridge@bnb.com",
#     "guest_first_name": "Wayne",
#     "guest_last_name": "Woodbridge",
#     "guest_phone_numbers": [
#       "639123456789",
#       "639123456789"
#     ],
#     "listing_security_price_accurate": "500.00",
#     "host_currency": "AUD",
#     "nights": 4,
#     "number_of_guests": 4,
#     "status_type": "accepted",
#     "total_paid_amount_accurate": "4300.00"
#   }
# }

# {
#   "reservation_code": "YYY12345678",
#   "start_date": "2021-04-14",
#   "end_date": "2021-04-18",
#   "nights": 4,
#   "guests": 4,
#   "adults": 2,
#   "children": 2,
#   "infants": 0,
#   "status": "accepted",
#   "guest": {
#     "first_name": "Wayne",
#     "last_name": "Woodbridge",
#     "phone": "639123456789",
#     "email": "wayne_woodbridge@bnb.com"
#   },
#   "currency": "AUD",
#   "payout_price": "4200.00",
#   "security_price": "500",
#   "total_price": "4700.00"
# }