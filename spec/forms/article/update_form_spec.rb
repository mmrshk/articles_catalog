# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article::UpdateForm do
  subject(:form) { described_class.new(params, current_admin, article).save }

  let(:current_admin) { create(:admin) }
  let!(:article) { create(:article, user_id: current_admin.id) }

  let(:tags) { create_list(:tag, 2) }
  let(:content) { FFaker::Lorem.paragraph }
  let(:category) { FFaker::Lorem.word }

  describe 'success' do
    context 'when params correct' do
      let(:params) do
        {
          content: content,
          category: category,
          article_tags: { tag_ids: article.tags.pluck(:id) + tags.pluck(:id) }
        }
      end

      it 'not changes Articles count' do
        expect { form }.not_to change(Article, :count)
      end

      it 'changes ArticleTags count' do
        expect { form }.to change(ArticleTag, :count).from(2).to(4)

        expect(current_admin.articles.first.article_tags.count).to eq(4)
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

  describe 'fail' do
    context 'when user is reader' do
      let(:current_admin) { create(:reader) }
      let(:admin) { create(:admin) }
      let!(:article) { create(:article, user_id: admin.id) }

      let(:params) do
        {
          content: content,
          category: category,
          article_tags: { tag_ids: tags.pluck(:id) }
        }
      end

      it 'not changes Articles count' do
        expect { form }.not_to change(Article, :count)
      end

      it 'not changes ArticleTags count' do
        expect { form }.not_to change(ArticleTag, :count)
      end

      it 'returns false' do
        expect(form).to be_falsey
      end
    end

    context 'when params invalid' do
      let(:params) do
        {
          content: '',
          category: '',
          article_tags: { tag_ids: [] }
        }
      end

      it 'not changes Articles count' do
        expect { form }.not_to change(Article, :count)
      end

      it 'not changes ArticleTags count' do
        expect { form }.not_to change(ArticleTag, :count)
      end

      it 'returns false' do
        expect(form).to be_falsey
      end
    end

    context 'when raises error on invalid tag_ids' do
      let(:params) do
        {
          content: content,
          category: category,
          article_tags: { tag_ids: [''] + tags.pluck(:id) }
        }
      end

      it 'not changes Articles count' do
        expect { form }.not_to change(Article, :count)
      end

      it 'not changes ArticleTags count' do
        expect { form }.not_to change(ArticleTag, :count)
      end

      it 'returns validation error' do
        expect(form).to be_falsey
      end
    end

    context 'when raises error' do
      before { allow(article).to receive(:update!).and_raise(ActiveRecord::RecordInvalid) }

      let(:params) do
        {
          content: content,
          category: category,
          article_tags: { tag_ids: tags.pluck(:id) }
        }
      end

      it 'not changes Articles count' do
        expect { form }.not_to change(Article, :count)
      end

      it 'not changes ArticleTags count' do
        expect { form }.not_to change(ArticleTag, :count)
      end

      it 'returns false' do
        expect(form).to eq(['Record invalid'])
      end
    end
  end
end
