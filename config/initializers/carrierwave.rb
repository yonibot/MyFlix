CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAJMBIV7AJ2SI5HQOQ',                        # required
    :aws_secret_access_key  => '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',                        # required
    :region                 => 'us-west-2',                  # optional, defaults to 'us-east-1'
    # :host                   => 's3.example.com',             # optional, defaults to nil
    # :endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
  }
  config.fog_directory  = 'myvideodata'                     # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
