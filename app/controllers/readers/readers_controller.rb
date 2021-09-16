# frozen_string_literal: true

module Readers
  class ReadersController < ApplicationController
    def show
      authorize current_user, policy_class: ReaderPolicy
    end
  end
end
