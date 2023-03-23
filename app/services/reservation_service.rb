class ReservationService
  def initialize(payload)
    @payload = payload
  end

  def call
    ActiveRecord::Base.transaction do
      adapted_response = ReservationAdapter.adapt(@payload)
      # Create or update the Guest record
      guest = Guest.find_or_initialize_by(email: adapted_response.dig(:guest, :email))
      guest.update!(adapted_response[:guest])

      # Create or update the Reservation record
      reservation = Reservation.find_or_initialize_by(reservation_code: adapted_response.dig(:reservation, :reservation_code))
      reservation.update!(adapted_response[:reservation].merge(guest_id: guest.id))
    end
  end
end