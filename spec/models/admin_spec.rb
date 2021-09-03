# frozen_string_literal: true

# == Schema Information
#
# Table name: default_users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  type                   :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#
require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:articles).class_name('Article') }
  end
end
