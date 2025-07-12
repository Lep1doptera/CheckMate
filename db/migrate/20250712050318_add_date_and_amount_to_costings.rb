class AddDateAndAmountToCostings < ActiveRecord::Migration[7.1]
  def change
    add_column :costings, :date, :date
    add_column :costings, :amount, :decimal, precision: 8, scale: 2
  end
end
