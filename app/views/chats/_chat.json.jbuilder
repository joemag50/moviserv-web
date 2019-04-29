json.extract! chat, :id, :from_user, :to_user, :created_at, :updated_at
json.url chat_url(chat, format: :json)
