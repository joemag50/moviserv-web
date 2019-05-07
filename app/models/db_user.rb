class DbUser < ApplicationRecord
  belongs_to :db_server
  before_create :create_query

  def create_query
    server = DbServer.find(self.db_server_id)
    offset = rand(server.db_tables.count)
    self.query = "SELECT * FROM #{server.db_tables.offset(offset).first.name};"
  end
end
