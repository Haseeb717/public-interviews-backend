# frozen_string_literal: true

class Auth::SessionsController < DeviseTokenAuth::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
      # super
  # end

  # POST /resource/sign_in
  def create
    @resource = nil

    # Check
    field = (resource_params.keys.map(&:to_sym) & resource_class.authentication_keys).first
    @resource = nil
    if field
      q_value = get_case_insensitive_field_from_resource_params(field)
      @resource = find_resource(field, q_value)
    end

    if @resource && (!@resource.respond_to?(:active_for_authentication?) || @resource.active_for_authentication?)
      if field.to_s == "email"
        valid_password = @resource.valid_password?(resource_params[:password])
        if (@resource.respond_to?(:valid_for_authentication?) && !@resource.valid_for_authentication? { valid_password }) || !valid_password
          return render_create_error_bad_credentials
        end
      end
      @token = @resource.create_token
      @resource.save

      sign_in(:user, @resource, store: false, bypass: false)

      yield @resource if block_given?

      render_create_success
    else
      render_create_error_bad_credentials
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  private

  # Serializign the response via serializer
  # def render_create_success
  #   json_response("#{@resource.class}Serializer".constantize.new(@resource).serialized_json, 200)
  # end

  def render_create_error_not_confirmed
    json_response({errors: {
      email: [{error: :not_confirmed}]
    }}, 401)
  end

  def render_create_error_bad_credentials
    json_response({errors: {
      email: [{error: :bad_credentials}]
    }}, 401)
  end

  def render_create_error_account_locked
    json_response({errors: {
      email: [{error: :account_locked}]
    }}, 401)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :phone_number])
  end
end