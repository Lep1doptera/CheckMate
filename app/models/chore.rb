class Chore < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :household

  validates :name, presence: true
  validates :description, presence: true
  validates :date_to_be_completed, presence: true

  def due_label
    completed? ? "✅ #{name}" : name
  end
end
