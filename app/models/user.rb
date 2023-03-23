class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one_attached :photo

  after_commit :add_default_photo, on: %i[create update]

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }

  def photo_thumbnail
    photo.variant(resize: '100x100!').processed
  end

  private

  def add_default_photo
    return if photo.attached?

    photo.attach(
      io: File.open(
        Rails.root.join(
          'app', 'assets', 'images', 'user_default.png'
        )
      ),
      filename: 'user_default.png',
      content_type: 'image/png'
    )
  end
end
