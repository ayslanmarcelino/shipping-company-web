# frozen_string_literal: true

class CtesController < UsersController
  before_action :set_cte, only: %w[edit update destroy show]
  before_action :set_user, only: %w[new create edit]
  before_action :set_truckload, only: %w[new create edit]

  def index
    @ctes = Cte.accessible_by(current_ability).order(created_at: :desc)
  end

  def new
    @cte = Cte.new
  end

  def create
    @cte = Cte.new(params_cte)
    @cte.validate_all = true

    @cte.save ? (redirect_to ctes_path, notice: 'CT-e cadastrado com sucesso') : (render :new)
  end

  def edit; end

  def update
    @cte.validate_all = true
    @cte.update(params_cte) ? (redirect_to ctes_path, notice: 'CT-e atualizado com sucesso') : (render :edit)
  end

  def destroy
    @cte.destroy ? (redirect_to ctes_path, notice: 'CT-e excluído com sucesso') : (render :index)
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
