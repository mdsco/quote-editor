class Company < ApplicationRecord
  has_many :quotes
  has_many :users

  validates :name, presence: true
end
