class CreateServerTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :server_tasks do |t|
      t.string :name
      t.string :user
      t.integer :pid
      t.float :cpu
      t.float :mem
      t.timestamp :time
      t.integer :status
      t.integer :server_id

      t.timestamps
    end
  end
end
