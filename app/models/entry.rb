class Entry < ApplicationRecord
  belongs_to :author, foreign_key: :author_id, class_name: 'User'
  has_many :group_entries, dependent: :destroy
  has_many :groups, through: :group_entries

  validates :name, presence: true, length: { maximum: 100 }
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
