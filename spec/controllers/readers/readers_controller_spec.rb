# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Readers::ReadersController, type: :controller do
  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(current_user)

    request
  end

  describe 'GET readers/readers#show' do
    subject(:request) { get :show, params: { id: reader.id } }

    let(:reader) { create(:reader) }

    context 'when admin authorized' do
      let!(:current_user) { create(:admin) }

      include_examples 'returns not authorized error'
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
