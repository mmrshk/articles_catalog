# frozen_string_literal: true

# == Schema Information
#
# Table name: articles_searches
#
#  article_id    :bigint           primary key
#  category      :string
#  tsv_category  :tsvector
#  term          :text
#  tsv_term      :tsvector
#  tag_names     :string           is an Array
#  tsv_tag_names :tsvector
#
require 'rails_helper'

RSpec.describe ArticlesSearch, type: :model do
  let(:current_admin) { create(:admin) }
  let(:category) { 'Test' }

  context 'when on create sets correct field values for ArticlesSearch' do
    let!(:article) do
      create(:article, user_id: current_admin.id, category: category, article_tags_count: article_tags_count)
    end
    let(:article_tags_count) { 1 }

    it 'sets correct category' do
      expect(described_class.first.category).to eq(category)
    end

    it 'sets correct term' do
      expect(described_class.first.term).to eq(article.content.to_plain_text)
    end

    it 'sets correct tag_names' do
      expect(described_class.first.tag_names).to eq(article.tags.pluck(:name))
    end
  end

  describe '#tsv_articles_search' do
    let!(:articles) do
      create_list(:article, 2, user_id: current_admin.id, category: category, article_tags_count: article_tags_count)
    end
    let(:search) { described_class.tsv_articles_search(category) }

    context 'when tags count in articles equal to one' do
      let(:article_tags_count) { 1 }

      it 'returns correct count for search' do
        expect(search.count).to eq(2)
      end
    end

    context 'when tags count in articles equal to two' do
      let(:article_tags_count) { 2 }

      it 'returns correct count for search' do
        expect(search.count).to eq(2)
      end
    end
  end
end
