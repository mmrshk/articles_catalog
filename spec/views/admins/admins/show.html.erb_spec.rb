# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'admins/admins/show', type: :view do
  context 'when no articles' do
    it 'renders show view correctly' do
      render

      expect(rendered).to have_link(text: 'Batch upload')
      expect(rendered).to have_link(text: 'New Article')
      expect(rendered).to have_selector('th', text: 'Articles count 0')
      expect(rendered).to have_table('articles_table', with_rows: [])
    end
  end

  context 'when articles' do
    let(:admin) { create(:admin) }
    let!(:article) { create(:article, user_id: admin.id) }
    let(:articles_search) { ArticleSearch.first }

    it 'renders headers correctly' do # rubocop:disable RSpec/ExampleLength
      render

      expect(rendered).to have_selector('th', text: '#')
      expect(rendered).to have_selector('th', text: 'Category')
      expect(rendered).to have_selector('th', text: 'Status')
      expect(rendered).to have_selector('th', text: 'Tags')
      expect(rendered).to have_selector('th', text: 'Content')
      expect(rendered).to have_selector('th', text: 'Articles count 1')
    end

    it 'renders body correctly' do
      render

      expect(rendered).to have_selector('td', text: article.id)
      expect(rendered).to have_selector('td', text: article.category)
      expect(rendered).to have_selector('td', text: article.tags.pluck(:name).join(','))
    end
  end
end
