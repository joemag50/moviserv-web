json.extract! server, :id, :name, :address, :user_id, :created_at, :updated_at
json.url server_url(server, format: :json)
