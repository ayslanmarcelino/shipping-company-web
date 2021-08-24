class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage(Rails.env.production? || ENV['FORCE_FOG'] == 'true' ? :fog : :file)

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :large_image do
    process resize_to_fill: [150, 150]
  end

  version :medium_image do
    process resize_to_fill: [50, 50]
  end

  version :small_image do
    process resize_to_fill: [35, 35]
  end

  def extension_white_list
    %w[jpg jpeg gif png]
  end
end
