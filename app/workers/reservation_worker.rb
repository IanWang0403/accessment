class ReservationWorker
  include Sidekiq::Worker

  def perform(event_id)
    event = WebhookEvent.find(event_id)
    ReservationService.new(event.payload).call
  end
end