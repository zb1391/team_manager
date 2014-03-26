json.array!(@payment_notifications) do |payment_notification|
  json.extract! payment_notification, :id, :params, :organization_id, :status, :transaction_id, :amount
  json.url payment_notification_url(payment_notification, format: :json)
end
