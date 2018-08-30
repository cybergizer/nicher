class ApplicationUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def default_url
    ActionController::Base.helpers.asset_path([version_name, self.class::URL].compact.join('_'))
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
