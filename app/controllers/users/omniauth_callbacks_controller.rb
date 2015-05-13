class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(provider)
    class_eval %Q(
def #{provider}
@user = User.find_for_oauth(request.env["omniauth.auth"])

if @user.persisted?
sign_in_and_redirect @user, event: :authentification
set_flash_message(:notice, :success, kind: "#{provider}") if is_navigational_format?
else
session["devise.#{provider}_data"] = request.env["omniauth.auth"].uid
redirect_to jobs_url
end
end
)
  end

  [:twitter].each do |provider|
    provides_callback_for(provider)
  end
end