# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id            :bigint           not null, primary key
#  category      :string
#  tsv_category  :tsvector
#  tsv_content   :tsvector
#  upload_errors :text             default([]), is an Array
#  status        :string           default("draft"), not null
#  user_id       :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :article do
    transient do
      with_article_tags { true }
      article_tags_count { 2 }
    end

    category { FFaker::Lorem.word }
    content { FFaker::Lorem.paragraph } # how to be here, it must be ActionText value

    after(:create) do |article, evaluator|
      if evaluator.with_article_tags
        evaluator.article_tags_count.times { create(:article_tag, tag_id: create(:tag).id, article_id: article.id) }
      end
    end

    trait :in_process do
      status { 'in_process' }
    end

    trait :failed do
      status { 'failed' }
    end

    trait :active do
      status { 'active' }
    end

    trait :inactive do
      status { 'inactive' }
    end
  end
end
