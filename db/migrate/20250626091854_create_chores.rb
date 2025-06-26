class CreateChores < ActiveRecord::Migration[7.1]
  def change
    create_table :chores do |t|
      t.references :user, null: false, foreign_key: true
      t.references :household, null: false, foreign_key: true
      t.boolean :assigned
      t.string :name
      t.string :description
      t.date :date_created
      t.date :date_to_be_completed
      t.boolean :completed
      t.date :completion_date

      t.timestamps
    end
  end
end
