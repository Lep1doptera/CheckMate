class ChangeUserIdToBeNullableInChores < ActiveRecord::Migration[7.1]
  def change
    change_column_null :chores, :user_id, true
  end
end
