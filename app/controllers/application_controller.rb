# frozen_string_literal: true

class ApplicationController < ActionController::API
  attr_writer :resource

  def user_by_token
    token = request.headers[:Authorization].split
    Warden::JWTAuth::UserDecoder.new.call(token[1], :user, nil)
  end

  def devise_parameter_sanitizer
    @devise_parameter_sanitizer ||= Devise::ParameterSanitizer.new(User, :user, params)
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
