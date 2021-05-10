# frozen_string_literal: true

class AdminsController < UsersController
  before_action :admin?

  private

  def admin?
    if !current_user.is_admin
      redirect_to root_path
      flash[:danger] = 'Você não tem permissão para acessar esta página' 
    end
  end
end
