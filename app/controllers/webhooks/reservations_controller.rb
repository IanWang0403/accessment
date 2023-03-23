class Webhooks::ReservationsController < Webhooks::BaseController
  def webhook
    event = WebhookEvent.create!(event_type: params[:event_type], payload: params[:payload])
    ReservationWorker.perform_async(event.id)
    head :ok
  end
end