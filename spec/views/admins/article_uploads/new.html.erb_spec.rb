# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'admins/article_uploads/new', type: :view do
  context 'when no articles' do
    before { view.instance_variable_set(:@article_upload, build(:article_upload)) }

    it 'renders show view correctly' do
      render

      expect(rendered).to have_selector('button', text: 'Add one more article')
    end
  end
end
