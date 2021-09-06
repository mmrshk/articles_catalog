# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    private

    def sign_up_params
      params.require(:user).permit(:type, :email, :password, :password_confirmation)
    end
  end
end
