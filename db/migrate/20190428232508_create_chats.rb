class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :from_user
      t.integer :to_user

      t.timestamps
    end
  end
end
