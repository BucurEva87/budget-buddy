class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :groups, dependent: :destroy
  has_many :entries, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
end
