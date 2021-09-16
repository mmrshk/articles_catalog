# frozen_string_literal: true

FactoryBot.define do
  factory :article_upload do
    attachment { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/text.txt'), 'text/plain') }
  end
end
