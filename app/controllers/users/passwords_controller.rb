# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  # GET /users/password/new
  def new
    redirect_to root_path
    super
  end

  # POST /users/password
  def create
    redirect_to root_path
    super
  end

  # GET /users/password/edit?reset_password_token=abcdef
  def edit
    redirect_to root_path
    super
  end

  # PUT /users/password
  def update
    redirect_to root_path
    super
  end

  # protected

  # def after_resetting_password_path_for(users)
  #   super(users)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
