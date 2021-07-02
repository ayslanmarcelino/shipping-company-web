# frozen_string_literal: true

module Uploader
  class Base < CarrierWave::Uploader::Base
    storage(Rails.env.production? || ENV['FORCE_FOG'] == 'true' ? :fog : :file)

    def filename
      File.basename(file.path) if file.present?
    end

    def file_extension
      file.extension if file.present?
    end

    def path_io
      production? ? url : path
    end

    def cache_dir
      '/tmp/cache/'
    end

    def store_dir
      name = model_name || model.model_name.name
      "uploads/#{name.to_s.underscore}/#{model.id}/#{mounted_as}"
    end

    def fog_authenticated_url_expiration
      3.days
    end

    def size_range
      1.byte..50.megabytes
    end

    def with_local_tempfile!
      tf = Tempfile.new(filename)
      bf = tf.binmode
      bf.write(file.read)
      bf.rewind
      yield(bf)
    ensure
      tf&.close
      tf&.unlink
    end

    def model_name; end

    protected

    def production?
      Rails.env.production?
    end
  end

  def self.for(extensions: nil, content_types: nil, model_name: nil)
    Class.new(Base).tap do |klass|
      klass.define_method(:extension_whitelist) { extensions } if extensions
      klass.define_method(:content_type_whitelist) { content_types } if content_types
      klass.define_method(:model_name) { model_name }
    end
  end

  ScannedDocument = self.for(
    content_types: %r{^(image/.*|application/pdf)$},
    extensions: %w[pdf jpg jpeg jpe jif jfif jfi png webp tif tiff bmp svg svgz]
  )
  PdfDocument = self.for(content_types: %r{^(application/pdf)$}, extensions: %w[pdf])
  Document = self.for(
    content_types: %r{^(application/pdf|application/vnd.oasis.open.*)$},
    extensions: %w[pdf odt ott oth odm odg otg odp otp ods ots odc odf odb odi]
  )
  StylesheetDocument = self.for(
    content_types: %r{^(application/vnd.ms-excel|application.vnd.open.*|application/zip)$},
    extensions: %w[csv xls xlsx zip]
  )
end
