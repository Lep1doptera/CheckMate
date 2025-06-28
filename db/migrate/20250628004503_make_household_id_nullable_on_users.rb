class MakeHouseholdIdNullableOnUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_null :users, :household_id, true
  end
end
