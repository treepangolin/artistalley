class ImageUploader < Shrine
  Attacher.validate do
    validate_mime_type %w[image/jpeg image/png image/webp image/tiff image/gif]
    validate_extension %w[jpg jpeg png webp tiff tif gif]
  end

  Attacher.derivatives do |original|
    vips = ImageProcessing::Vips.source(original)

    {
      scaled: vips.resize!(0.8)
    }
  end

  Attacher.promote_block do
    PromoteJob.perform_now(record, name, file_data)
  end
end
