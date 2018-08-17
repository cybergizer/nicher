require 'carrierwave/orm/activerecord'

if Rails.env.test? || Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.permissions = 0o666
    config.directory_permissions = 0o777
    config.root = Rails.root
    config.storage = :file
    config.enable_processing = false
  end

  @avatar = AvatarUploader

  # use different dirs when testing
  CarrierWave::Uploader::Base.descendants.each do |klass|
    next if klass.anonymous?
    klass.class_eval do
      def cache_dir
        "#{Rails.root}/spec/support/uploads/tmp/#{model.id}"
      end

      def store_dir
        "#{Rails.root}/spec/support/uploads/#{model.id}"
      end
    end
  end
else
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.fog_credentials = { provider:              'AWS',
                               aws_access_key_id:     ENV['S3_KEY'],
                               aws_secret_access_key: ENV['S3_SECRET'],
                               region:                ENV['S3_REGION'] }
    config.fog_directory = ENV['S3_BUCKET']
    config.storage = :fog
  end
end
