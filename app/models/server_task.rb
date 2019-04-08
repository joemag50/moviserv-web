class ServerTask < ApplicationRecord
  enum status: %i[started stoped restarting]
end
