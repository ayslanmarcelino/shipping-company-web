# frozen_string_literal: true

module Admins
  class EnterprisesController < AdminsController
    before_action :set_enterprise, only: %w[edit update]
    
    def edit; end

    def update
      if @enterprise.update(params_enterprise)
        redirect_to dashboard_index_path
        flash[:success] = 'Empresa atualizada com sucesso.'
      else
        redirect_to edit_admins_enterprise_path(current_user.enterprise)
      end
    end

    private

    def set_enterprise
      if current_user.enterprise_id == Enterprise.find(params[:id]).id
        @enterprise = Enterprise.find(params[:id])
      else
        redirect_to root_path
        flash[:danger] = 'Você não tem permissão para editar esta empresa.' 
      end
    end

    def params_enterprise
      params.require(:enterprise).permit(:logo, :primary_color, :secondary_color)
    end
  end
end
