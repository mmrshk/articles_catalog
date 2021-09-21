# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Readers::ArticlesController, type: :controller do
  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(current_user)

    request
  end

  describe 'GET readers/articles#index' do
    subject(:request) { get :index }

    context 'when admin authorized' do
      let!(:current_user) { create(:admin) }

      include_examples 'returns not authorized error'
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
    subject(:request) { get :show, params: { id: article.id } }

    let(:admin) { create(:admin) }
    let(:article) { create(:article, user_id: admin.id) }

    context 'when admin authorized' do
      let!(:current_user) { admin }

      include_examples 'returns not authorized error'
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
