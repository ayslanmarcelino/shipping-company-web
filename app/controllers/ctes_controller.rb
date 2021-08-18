# frozen_string_literal: true

class CtesController < UsersController
  before_action :set_cte, only: %w[edit update destroy show]
  before_action :set_user, only: %w[edit]
  before_action :set_truckload, only: %w[edit]

  def index
    @ctes = Cte.accessible_by(current_ability).order(created_at: :desc)
  end

  def edit; end

  def update
    @cte.validate_all = true
    if @cte.update(params_cte)
      redirect_to ctes_path
      flash[:success] = 'CT-e atualizado com sucesso'
    else
      render :edit
    end
  end

  def destroy
    if @cte.destroy
      redirect_to ctes_path
      flash[:success] = 'CT-e excluído com sucesso'
    else
      render :index
    end
  end

  private

  def set_cte
    if current_user.cte_ids.include?(Cte.find(params[:id]).id) ||
       current_user.roles.kind_masters.present? ||
       (current_user.roles.kind_owners.present? &&
        current_user.enterprise_id == Cte.find(params[:id]).enterprise_id)
      @cte = Cte.find(params[:id])
    else
      redirect_to root_path
      flash[:danger] = 'Você não tem permissão para manipular este CT-e.'
    end
  end

  def set_user
    @user = User.where(id: current_user.id)
  end

  def set_truckload
    @truckloads = Truckload.where(user: current_user).order(created_at: :desc)
  end

  def params_cte
    params.require(:cte)
          .permit(:cte_number, :value, :truckload_id, :user_id)
          .with_defaults(user: current_user, enterprise: current_user.enterprise)
  end
end
