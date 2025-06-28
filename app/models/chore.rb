class Chore < ApplicationRecord
  belongs_to :user
  belongs_to :household

  validates :name, presence: true
  validates :description, presence: true
  validates :date_to_be_completed, presence: true
end
