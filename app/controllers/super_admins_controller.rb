# frozen_string_literal: true

class SuperAdminsController < UsersController
  before_action :super_admin?

  private

  def super_admin?
    if !current_user.is_super_admin
      redirect_to root_path
      flash[:danger] = 'Você não tem permissão para acessar esta página'
    end
  end
end
