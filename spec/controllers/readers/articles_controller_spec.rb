# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Readers::ArticlesController, type: :controller do
  describe 'GET readers/articles#index' do
    before do
      allow(controller).to receive(:authenticate_user!).and_return(true)
      allow(controller).to receive(:current_user).and_return(current_user)

      get :index
    end

    context 'when admin authorized' do
      let!(:current_user) { create(:admin) }

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

    context 'when reader authorized' do
      let!(:current_user) { create(:reader) }

      it 'returns success status' do
        expect(response).to have_http_status(:success)
      end

      it 'doesn`t set a flash message' do
        expect(flash['alert']).to be_nil
      end
    end
  end

  describe 'GET readers/articles#show' do
    let(:admin) { create(:admin) }
    let(:article) { create(:article, user_id: admin.id) }

    before do
      allow(controller).to receive(:authenticate_user!).and_return(true)
      allow(controller).to receive(:current_user).and_return(current_user)

      get :show, params: { id: article.id }
    end

    context 'when admin authorized' do
      let!(:current_user) { admin }

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

    context 'when reader authorized' do
      let!(:current_user) { create(:reader) }

      it 'returns success status' do
        expect(response).to have_http_status(:success)
      end

      it 'doesn`t set a flash message' do
        expect(flash['alert']).to be_nil
      end
    end
  end
end
