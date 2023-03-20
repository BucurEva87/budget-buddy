class Group < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :icon, presence: true,
                   format: {
                     with: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/,
                     message: 'must be a valid URL'
                   }
end
