# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    transient do
      with_article_tags { true }
      article_tags_count { 2 }
    end

    category { FFaker::Lorem.word }
    content { FFaker::Lorem.paragraph } # how to be here, it must be ActionText value
    status { 'active' }

    after(:create) do |article, evaluator|
      if evaluator.with_article_tags
        evaluator.article_tags_count.times { create(:article_tag, tag_id: create(:tag).id, article_id: article.id) }
      end
    end
  end
end
