class AddFieldsToQuery < ActiveRecord::Migration[6.1]
  def change
    add_reference :queries, :user, null: false, foreign_key: true
    add_column :queries, :name, :string
    add_column :queries, :profile_url, :string
    add_column :queries, :repositories, :json
    add_column :queries, :avatar, :string
  end
end
