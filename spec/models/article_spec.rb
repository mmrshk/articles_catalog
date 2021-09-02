# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id              :bigint           not null, primary key
#  category        :string           not null
#  tsv_category    :tsvector
#  content         :string           not null
#  tsv_content     :tsvector
#  status          :string           default("draft"), not null
#  default_user_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:admin).class_name('Admin') }
    it { is_expected.to have_many(:tags).class_name('Tag') }
  end
end
