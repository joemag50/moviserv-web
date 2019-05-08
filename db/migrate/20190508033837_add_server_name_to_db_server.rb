class AddServerNameToDbServer < ActiveRecord::Migration[5.2]
  def change
    add_column :db_servers, :server_name, :string
  end
end
