class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
	before_action :configure_permitted_parameters, if: :devise_controller?



  def after_sign_in_path_for(resource)
      user_path(resource)
  end

  def after_sign_up_path_for(resource)
      user_path(resource)
  end
  def after_inactive_sign_up_path_for(resource)
      user_path
  end

  def after_sign_out_path_for(resource)
      root_path(resource)
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email,:postcode, :prefecture_code, :address_city, :address_street])
  end

end
