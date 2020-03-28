class ApplicationController < ActionController::Base
  #before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  #after_action :store_action


  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

def after_sign_in_path_for(resource_or_scope)
  stored_location_for(resource_or_scope) || super
end

def after_sign_up_path_for(resource_or_scope)
  stored_location_for(resource_or_scope) || super
end

def after_edit_path_for(resource_or_scope)
  stored_location_for(resource_or_scope) || super
end

def store_action
  return unless request.get?
  if (request.path != "/users/sign_in" &&
      request.path != "/users/sign_up" &&
      request.path != "/users/password/new" &&
      request.path != "/users/password/edit" &&
      request.path != "/users/confirmation" &&
      request.path != "/users/sign_out" &&
      request.path != "/stripe-webhooks"
      !request.xhr?) # don't store ajax calls
    store_location_for(:user, request.fullpath)
  end
end

  def configure_permitted_parameters
      # For additional fields in app/views/devise/registrations/new.html.erb
        devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])

      # For additional in app/views/devise/registrations/edit.html.erb
        devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :dob, :avatar])
      # Uncomment when you *really understand* Pundit!
      # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
      # def user_not_authorized
      #   flash[:alert] = "You are not authorized to perform this action."
      #   redirect_to(root_path)
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
      # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

end
