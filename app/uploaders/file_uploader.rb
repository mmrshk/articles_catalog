# frozen_string_literal: true

require 'docx'

class FileUploader < CarrierWave::Uploader::Base
  storage :file

  CONTENT_TYPES = {
    txt: 'text/plain',
    docx: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
  }.freeze

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w[txt doc htm html docx]
  end

  def read
    if file.content_type == CONTENT_TYPES[:txt]
      File.read file.file
    elsif file.content_type == CONTENT_TYPES[:docx]
      doc = Docx::Document.open(file.path)
      paragraphs = []

      doc.paragraphs.each { |paragraph| paragraphs << paragraph }

      paragraphs.join('<br>').html_safe
    else
      'Enetered file cannot be readen'
    end
  end
end
