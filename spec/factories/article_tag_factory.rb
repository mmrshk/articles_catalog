# frozen_string_literal: true

# == Schema Information
#
# Table name: article_tags
#
#  id         :bigint           not null, primary key
#  article_id :bigint           not null
#  tag_id     :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :article_tag do
  end
end
