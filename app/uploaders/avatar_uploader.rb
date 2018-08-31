class AvatarUploader < ApplicationUploader
  URL = 'avatar.png'.freeze

  def store_dir
    "users/avatars/#{model.id}"
  end

  version :thumb do
    process resize_to_fill: [250, 250]
  end

  version :small do
    process resize_to_fill: [50, 50]
  end
end
