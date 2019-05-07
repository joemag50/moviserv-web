class CreateDbServers < ActiveRecord::Migration[5.2]
  def change
    create_table :db_servers do |t|
      t.integer :server_id
      t.string :name

      t.timestamps
    end
  end
end
