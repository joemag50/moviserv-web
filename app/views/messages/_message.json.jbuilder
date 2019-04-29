json.extract! message, :id, :message, :chat_id, :created_at, :updated_at
json.url message_url(message, format: :json)
