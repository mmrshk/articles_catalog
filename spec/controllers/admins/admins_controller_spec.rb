# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admins::AdminsController, type: :controller do
  subject(:request) { get :show, params: { 'id' => current_user.id } }

  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(current_user)

    request
  end

  describe 'GET admins/admins#show' do
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

      include_examples 'returns not authorized error'
    end
  end
end
