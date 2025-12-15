class Category < ApplicationRecord
  has_many :conversations
  validates :name, presence: true, uniqueness: true
end
