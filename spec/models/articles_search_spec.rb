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
  describe '#tsv_articles_search' do
    let!(:articles) { create_list(:article, 2, user_id: current_admin.id, category: category, article_tags_count: 1) }

    let(:search) {  described_class.tsv_articles_search(category) }
    let(:current_admin) { create(:admin) }
    let(:category) { 'Test' }

    it '' do
      expect(search.count).to eq(2)
    end
  end
end
