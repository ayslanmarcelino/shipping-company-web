# frozen_string_literal: true

CarrierWave.configure do |config|
  if Rails.env.production? || ENV['FORCE_FOG'] == 'true'
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: ENV['S3_PROVIDER'],
      aws_access_key_id: ENV['S3_ACCESS_KEY'],
      aws_secret_access_key: ENV['S3_SECRET_KEY']
    }
    config.fog_directory  = ENV['S3_BUCKET']
    config.fog_public     = false
    config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
    config.delete_tmp_file_after_storage = false
  elsif Rails.env.test?
    config.storage = :file
    config.cache_dir = Rails.root.join('tmp/uploads')
    config.enable_processing = false
  end
end
