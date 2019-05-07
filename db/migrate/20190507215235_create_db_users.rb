class CreateDbUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :db_users do |t|
      t.integer :db_server_id
      t.string :name

      t.timestamps
    end
  end
end
