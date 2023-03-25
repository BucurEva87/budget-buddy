class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  alias_attribute :image, :photo

  include BlobHelper

  has_one_attached :photo

  before_commit :attach_default_photo, on: %i[create update]

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validate :acceptable_image

  def photo_thumbnail
    photo.variant(resize: '100x100!').processed
  end

  private

  def attach_default_photo
    photo.attach(ActiveStorage::Blob.find_by(key: 'user_default')) unless photo.attached?
  end
end
