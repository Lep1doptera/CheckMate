class Household < ApplicationRecord
  has_many :users
  has_many :chores
  has_many :costings
end
