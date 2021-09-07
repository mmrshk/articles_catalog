# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticleForm do
  subject(:form) { described_class.new(params).submit }

  let!(:current_admin) { create(:admin) }

  let(:first_tag) { create(:tag) }
  let(:second_tag) { create(:tag) }
  let(:content) { FFaker::Lorem.paragraph }
  let(:category) { FFaker::Lorem.word }

  describe 'Success' do
    context 'when params correct' do
      let(:params) do
        {
          content: content,
          user_id: current_admin.id,
          category: category,
          article_tags: { tag_ids: [first_tag.id, second_tag.id] }
        }
      end

      it 'changes Articles count' do
        expect { form }.to change(Article, :count).from(0).to(1)
      end

      it 'changes ArticleTags count' do
        expect { form }.to change(ArticleTag, :count).from(0).to(2)
      end

      it 'creates a new instance of Article with correct values' do
        form

        article = current_admin.articles.first

        expect(article.content.to_plain_text).to eq(content)
        expect(article.category).to eq(category)
      end

      it 'sets correct status' do
        form

        expect(current_admin.articles.first).to be_active
      end
    end
  end

  describe 'Fail' do
    context 'when params invalid' do
      let(:params) do
        {
          content: '',
          user_id: current_admin.id,
          category: '',
          article_tags: { tag_ids: [] }
        }
      end

      it 'NOT changes Articles count' do
        expect { form }.not_to change(Article, :count)
      end

      it 'NOT changes ArticleTags count' do
        expect { form }.not_to change(ArticleTag, :count)
      end

      it 'returns false' do
        expect(form).to be_falsey
      end
    end

    context 'when ActiveRecord::RecordInvalid raises on invalid tag_ids' do
      let(:params) do
        {
          content: content,
          user_id: current_admin.id,
          category: category,
          article_tags: { tag_ids: ['', first_tag.id, second_tag.id] }
        }
      end

      it 'NOT changes Articles count' do
        expect { form }.not_to change(Article, :count)
      end

      it 'NOT changes ArticleTags count' do
        expect { form }.not_to change(ArticleTag, :count)
      end

      it 'returns validation error' do
        expect(form).to eq(['Validation failed: Article tags tag must exist'])
      end
    end

    context 'when ActiveRecord::RecordInvalid raises' do
      before { allow_any_instance_of(Article).to receive(:create!).and_raise(ActiveRecord::RecordInvalid) }

      let(:params) do
        {
          content: content,
          user_id: current_admin.id,
          category: category,
          article_tags: { tag_ids: [first_tag.id, second_tag.id] }
        }
      end

      it 'NOT changes Articles count' do
        expect { form }.not_to change(Article, :count)
      end

      it 'NOT changes ArticleTags count' do
        expect { form }.not_to change(ArticleTag, :count)
      end

      it 'returns false' do
        expect(form).to eq([''])
      end
    end
  end
end
