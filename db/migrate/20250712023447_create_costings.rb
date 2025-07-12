class CreateCostings < ActiveRecord::Migration[7.1]
  def change
    create_table :costings do |t|
      t.string :title
      t.string :description
      t.references :user, null: false, foreign_key: true
      t.references :household, null: false, foreign_key: true

      t.timestamps
    end
  end
end
