class AddMyTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :my_token, :string
  end
end
