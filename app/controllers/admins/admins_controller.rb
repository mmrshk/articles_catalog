# frozen_string_literal: true

module Admins
  class AdminsController < ApplicationController
    def show
      authorize current_user, policy_class: AdminPolicy
    end
  end
end
