CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => 'AKIAJMBIV7AJ2SI5HQOQ',                        # required
      :aws_secret_access_key  => '',                        # required
    }
    config.fog_directory  = 'myvideodata'                     # required
  else
    config.storage = :file
    config.enable_processing = Rails.env.development?
  end
end
