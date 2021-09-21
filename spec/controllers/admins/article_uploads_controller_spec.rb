# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admins::ArticleUploadsController, type: :controller do
  describe 'GET admins/article_uploads#new' do
    before do
      allow(controller).to receive(:authenticate_user!).and_return(true)
      allow(controller).to receive(:current_user).and_return(current_user)

      get :new
    end

    context 'when admin authorized' do
      let!(:current_user) { create(:admin) }

      it 'returns success status' do
        expect(response).to have_http_status(:success)
      end

      it 'doesn`t set a flash message' do
        expect(flash['alert']).to be_nil
      end
    end

    context 'when reader authorized' do
      let!(:current_user) { create(:reader) }

      it 'returns moved temporary status' do
        expect(response).to have_http_status(:found)
      end

      it 'redirects to correct path' do
        expect(response).to redirect_to(root_path)
      end

      it 'sets a flash message' do
        expect(flash['alert']).to eq('You are not authorized to perform this action.')
      end
    end
  end

  describe 'POST admins/article_uploads#upload' do
    let(:attachments) do
      {
        '0' => fixture_file_upload('files/text.txt', 'text/plain'),
        '1' => fixture_file_upload('files/text.txt', 'text/plain')
      }
    end

    before do
      allow(controller).to receive(:authenticate_user!).and_return(true)
      allow(controller).to receive(:current_user).and_return(current_user)
      allow(ArticleUploadService).to receive(:call).and_return(true)

      post :upload, params: { attachment: attachments }
    end

    context 'when admin authorized' do
      let!(:current_user) { create(:admin) }

      it 'returns moved temporary status' do
        expect(response).to have_http_status(:found)
      end

      it 'redirects to correct path' do
        expect(response).to redirect_to(root_path)
      end

      it 'doesn`t set a flash message' do
        expect(flash['alert']).to be_nil
      end
    end

    context 'when reader authorized' do
      let!(:current_user) { create(:reader) }

      it 'returns moved temporary status' do
        expect(response).to have_http_status(:found)
      end

      it 'sets a flash message' do
        expect(flash['alert']).to eq('You are not authorized to perform this action.')
      end

      it 'redirects to correct path' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
