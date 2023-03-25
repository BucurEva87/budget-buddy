module BlobHelper
  def acceptable_image
    return if image.blank?

    unless image.blob.byte_size <= 1.megabyte
      current_size = (image.blob.byte_size / 1000000.0).round(2)
      errors.add(:image, "size can not exceed 1 MB (current: #{current_size} MB)")
    end

    unless ['image/jpeg', 'image/png', 'image/webp'].include?(image.content_type)
      errors.add(:image, "format must be JPEG, PNG or WEBP (current: #{image.content_type})")
    end
  end
end
