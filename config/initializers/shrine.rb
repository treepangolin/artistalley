require 'shrine'
require 'shrine/storage/s3'
require 'image_processing/vips'

s3_options = {
  bucket: Rails.application.credentials.dig(:digitalocean, :bucket),
  access_key_id: Rails.application.credentials.dig(:digitalocean, :access_key_id),
  secret_access_key: Rails.application.credentials.dig(:digitalocean, :secret_access_key),
  endpoint: 'https://nyc3.digitaloceanspaces.com',
  region: 'nyc3'
}

Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: 'cache', upload_options: { acl: 'public-read' }, **s3_options),
  store: Shrine::Storage::S3.new(prefix: 'store', upload_options: { acl: 'public-read' }, **s3_options)
}

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :validation_helpers
Shrine.plugin :derivatives
Shrine.plugin :backgrounding
