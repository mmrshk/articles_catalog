# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'readers/articles/index', type: :view do
  context 'when no articles' do
    before { view.instance_variable_set(:@articles_searches, []) }

    it 'renders show view correctly' do
      render

      expect(rendered).to have_css('input', count: 2)
      expect(rendered).to have_selector('th', text: 'Articles count 0')
      expect(rendered).to have_table('articles_table', with_rows: [])
    end
  end

  context 'when articles' do
    let(:admin) { create(:admin) }
    let!(:article) { create(:article, user_id: admin.id) }

    before { view.instance_variable_set(:@articles_searches, [ArticlesSearch.first]) }

    it 'renders show view correctly' do
      render

      expect(rendered).to have_css('input[type="submit"]')
      expect(rendered).to have_css('input[type="text"]')
      expect(rendered).to have_selector('th', text: 'Articles count 1')
      expect(rendered).to have_table('articles_table', with_rows: [])
    end
  end
end
