class Entry < ApplicationRecord
  belongs_to :author

  validates :name, presence: true, length: { maximum: 100 }
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
