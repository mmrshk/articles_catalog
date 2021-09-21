# frozen_string_literal: true

RSpec.shared_examples 'returns not authorized error' do
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
