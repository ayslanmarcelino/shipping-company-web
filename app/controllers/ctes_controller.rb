# frozen_string_literal: true

class CtesController < UsersController
  before_action :set_cte, only: %w[destroy show]

  def index
    @q = Cte.includes([client: :address])
            .includes(:truckload)
            .includes([user: :person])
            .accessible_by(current_ability)
            .page(params[:page])
            .ransack(params[:q])

    @ctes = @q.result(distinct: false)
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
end
