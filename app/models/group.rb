class Group < ApplicationRecord
  has_many :entries, dependent: :destroy

  has_one_attached :icon

  after_commit :add_default_icon, on: %i[create update]

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }

  def icon_thumbnail
    icon.variant(resize: '150x150!').processed
  end

  private

  def add_default_icon
    return if icon.attached?

    icon.attach(
      io: File.open(
        Rails.root.join(
          'app', 'assets', 'images', 'group_default.png'
        )
      ),
      filename: 'group_default.png',
      content_type: 'image/png'
    )
  end
end
