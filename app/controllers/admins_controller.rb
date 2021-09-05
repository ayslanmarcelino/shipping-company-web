# frozen_string_literal: true

class AdminsController < ApplicationController
  before_action :admin?

  private

  def admin?
    if current_user.roles.kind_owners.empty? &&
       current_user.roles.kind_masters.empty? &&
       request.path.exclude?("users/#{current_user.id}")
      redirect_to root_path
      flash[:danger] = 'Você não possui permissão para acessar esta página.'
    end
  end
end
