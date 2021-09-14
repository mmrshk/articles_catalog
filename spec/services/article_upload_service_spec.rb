# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticleUploadService do
  subject(:service) { described_class.call(attachments, current_admin) }

  let(:current_admin) { create(:admin) }
  let(:attachments) do
    {
      '0' => fixture_file_upload('files/text.txt', 'text/plain'),
      '1' => fixture_file_upload('files/text.txt', 'text/plain')
    }
  end

  it 'changes ArticleUploads count' do
    expect { service }.to change(ArticleUpload, :count).by(2)
  end

  it 'calls ArticleAttachmentsUploadJob 2 times' do
    expect(ArticleAttachmentsUploadJob).to receive(:perform_later).twice

    service
  end
end
