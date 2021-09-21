# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Readers::ReadersController, type: :controller do
  describe 'GET readers/readers#show' do
    let(:reader) { create(:reader) }

    before do
      allow(controller).to receive(:authenticate_user!).and_return(true)
      allow(controller).to receive(:current_user).and_return(current_user)

      get :show, params: { id: reader.id }
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
      let!(:current_user) { reader }

      it 'returns success status' do
        expect(response).to have_http_status(:success)
      end

      it 'doesn`t set a flash message' do
        expect(flash['alert']).to be_nil
      end
    end
  end
end
