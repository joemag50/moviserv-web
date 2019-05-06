class EmailToMessage < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :email, :string
  end
end
