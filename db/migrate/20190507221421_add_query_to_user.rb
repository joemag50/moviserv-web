class AddQueryToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :db_users, :query, :string
  end
end
