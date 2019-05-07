class CreateDbTables < ActiveRecord::Migration[5.2]
  def change
    create_table :db_tables do |t|
      t.integer :db_server_id
      t.string :name

      t.timestamps
    end
  end
end
