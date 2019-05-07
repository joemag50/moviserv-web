class DbServer < ApplicationRecord
  belongs_to :server
  has_many :db_tables, dependent: :destroy
  has_many :db_users, dependent: :destroy

  def populate
    create_database
    create_users
  end

  def db_analitics
    object = {
      pg_tables: self.db_tables,
      pg_table_count: self.db_tables.count,
      pg_users: self.db_users,
      pg_users_count: self.db_users.count
    }
    object
  end

  private

  def create_database
    magic_number = Random.new.rand(25)

    for i in 0..magic_number
      DbTable.new(db_server_id: self.id, name: Faker::Internet.slug).save
    end
  end

  def create_users
    magic_number = Random.new.rand(25)

    for i in 0..magic_number
      DbUser.new(db_server_id: self.id, name: Faker::Internet.username).save
    end
  end
end
