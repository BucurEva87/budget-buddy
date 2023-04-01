class Group < ApplicationRecord
  alias_attribute :image, :icon

  include BlobHelper

  belongs_to :author, class_name: 'User'
  has_many :group_entries, dependent: :destroy
  has_many :entries, through: :group_entries

  has_one_attached :icon

  before_commit :attach_default_icon, on: %i[create update]

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }, uniqueness: { case_sensitive: false }
  validate :acceptable_image

  def icon_thumbnail
    icon.variant(resize: '128x128!').processed
  end

  def total_payments
    self.entries.sum(:amount).round(2)
  end

  private

  def attach_default_icon
    icon.attach(ActiveStorage::Blob.find_by(key: 'group_default')) unless icon.attached?
  end
end
