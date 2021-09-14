# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticleAttachmentsUploadJob, type: :job do
  let!(:article_upload) { create(:article_upload) }
  let(:current_admin) { create(:admin) }

  describe '#perform_later' do
    subject(:job) { described_class.perform_later(article_upload, current_admin.id) }

    it 'enqueues a job' do
      ActiveJob::Base.queue_adapter = :test
      expect do
        job
      end.to have_enqueued_job.with(article_upload, current_admin.id).on_queue('uploaders')
    end
  end

  # ?
  describe '#perform' do
    subject(:job) { described_class.perform_now(article_upload, current_admin.id) }

    it 'creates an Article' do
      expect { job }.to change(Article, :count).by(1)
    end

    it 'sets status inactive to Article' do
      job

      expect(Article.first).to be_inactive
    end

    it 'destroys an ArticleUpload' do
      expect { job }.to change(ArticleUpload, :count).by(-1)
    end

    it 'broadcasts a message' do
      job

      expect do
        ActionCable.server.broadcast(
          'notice_channel', { content: 'article already procceeded' }
        )
      end.to have_broadcasted_to('notice_channel').with(a_hash_including(content: 'article already procceeded'))
    end
  end
end
