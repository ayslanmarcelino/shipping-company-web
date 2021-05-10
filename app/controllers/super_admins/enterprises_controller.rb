# frozen_string_literal: true

module SuperAdmins
  class EnterprisesController < SuperAdminsController
    before_action :set_enterprise, only: %w[edit update destroy]
    rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

    def index
      @enterprises = Enterprise.all
    end

    def new
      @enterprise = Enterprise.new
    end

    def create
      @enterprise = Enterprise.new(params_enterprise)

      if @enterprise.save
        redirect_to super_admins_enterprises_path 
        flash[:success] = 'Empresa cadastrada com sucesso.'
      else
        render :new
      end
    end

    def edit; end

    def update
      if @enterprise.update(params_enterprise)
        redirect_to super_admins_enterprises_path
        flash[:success] = 'Empresa atualizada com sucesso.'
      else
        render :edit
      end
    end

    def destroy
      if @enterprise.destroy
        redirect_to super_admins_enterprises_path
        flash[:success] = 'Empresa excluída com sucesso.'
      else
        render :index
      end
    end

    private

    def set_enterprise
      @enterprise = Enterprise.find(params[:id])
    end

    def params_enterprise
      params.require(:enterprise).permit(:company_name, :description, :document_number, :email, :fantasy_name, :logo, :opening_date, :primary_color,
                                         :secondary_color, :is_active)
    end

    def invalid_foreign_key
      redirect_to super_admins_enterprises_path
      flash[:danger] = 'Não é possível excluir, pois há dados vinculados.'
    end
  end
end
