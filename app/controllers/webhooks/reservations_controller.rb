class Webhooks::ReservationsController < Webhooks::BaseController
  def webhook
    event = WebhookEvent.create!(event_type: params[:event_type], payload: params[:payload])
    ReservationWorker.perform_async(event.id)

    # or if you don't want to use Sidekiq:

    # ReservationService.new(params[:payload]).call

    head :ok
  end
end