# frozen_string_literal: true

class RedirectController < ApplicationController
  def index
    current_user.is_a?(Reader) ? redirect_to(reader_path(current_user.id)) : redirect_to(admin_path(current_user.id))
  end
end
