# CarrierWave.configure do |config|
#   if Rails.env.test?
#     config.storage = :file
#     config.enable_processing = false
#     config.root = "#{Rails.root}/tmp"
#   else
#     config.storage = :fog
#     config.fog_credentials = {
#       provider: "AWS",
#       aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
#       aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
#     }
#   end

#   config.cache_dir = "#{Rails.root}/public/tmp/uploads"

#   config.fog_directory = ENV["S3_BUCKET_NAME"]
#   config.fog_attributes = {}
# end

CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket = ENV.fetch('S3_BUCKET_NAME')
  config.aws_acl    = 'public-read'

  config.aws_credentials = {
    access_key_id:     ENV.fetch('AWS_ACCESS_KEY_ID'),
    secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
    region:            ENV.fetch('AWS_REGION') # Required
  }
end
