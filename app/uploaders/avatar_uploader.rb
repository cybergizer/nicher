# frozen_string_literal: true

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "users/avatars/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path([version_name, 'avatar.png'].compact.join('_'))
  end

  version :thumb do
    process resize_to_fill: [250, 250]
  end

  version :small do
    process resize_to_fill: [50, 50]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
