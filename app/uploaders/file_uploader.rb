# frozen_string_literal: true

require 'docx'

class FileUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w[txt doc htm html docx]
  end

  def read
    # type here can be anyone, check explicitly each type
    if file.content_type == 'text/plain'
      File.read file.file
    else
      doc = Docx::Document.open(file.path)
      paragraphs = []

      doc.paragraphs.each { |paragraph| paragraphs << paragraph }

      paragraphs.join('<br>').html_safe
    end
  end
end
