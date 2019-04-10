class Ingredient < ApplicationRecord
  validates :name, presence: true
  has_many :doses, dependent: :delete_all
end
