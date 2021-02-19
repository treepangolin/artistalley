class ImageUploader < Shrine
  Attacher.validate do
    validate_mime_type %w[image/jpeg image/png image/webp image/tiff image/gif]
    validate_extension %w[jpg jpeg png webp tiff tif gif]
  end

  Attacher.derivatives do |original|
    vips = ImageProcessing::Vips.source(original)

    {
      small: vips.resize_to_limit!(256, 256),
      medium: vips.resize_to_limit!(512, 512),
      medium_large: vips.resize_to_limit!(896, 896),
      large: vips.resize_to_limit!(1024, 1024)
    }
  end

  Attacher.promote_block do
    PromoteJob.perform_now(record, name, file_data)
  end
end
