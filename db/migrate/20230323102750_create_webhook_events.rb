class CreateWebhookEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :webhook_events do |t|
      t.string :event_type
      t.jsonb :payload
      t.timestamps
    end
  end
end