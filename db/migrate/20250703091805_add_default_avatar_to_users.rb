class AddDefaultAvatarToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :default_avatar, :string
  end
end
