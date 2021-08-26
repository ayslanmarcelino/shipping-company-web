# frozen_string_literal: true

class CtesController < UsersController
  before_action :set_cte, only: %w[destroy show]

  def index
    return if cannot?(:read, Cte) && unauthorized_redirect

    @q = Cte.includes([client: :address], :truckload)
            .accessible_by(current_ability)
            .page(params[:page])
            .ransack(params[:q])

    @ctes = @q.result(distinct: false)
  end

  def show
    return if cannot?(:read, Cte) && unauthorized_redirect
  end

  def destroy
    return if cannot?(:destroy, Cte) && unauthorized_redirect

    can_destroy_cte = true if current_user.roles.kind_masters.present? ||
                              Cte.find(params[:id]).truckload.user == current_user

    if can_destroy_cte
      if @cte.destroy
        redirect_to ctes_path
        flash[:success] = 'CT-e excluído com sucesso'
      else
        render :index
      end
    else
      redirect_to(ctes_path)
      flash[:danger] = 'Você não pode deletar o CT-e de terceiros.'
    end
  end

  private

  def unauthorized_redirect
    redirect_to(root_path)
    flash[:danger] = 'Você não possui permissão para realizar esta ação.'
  end

  def set_cte
    if current_user.roles.kind_masters.present? ||
       current_user.enterprise_id == Cte.find(params[:id]).enterprise_id
      @cte = Cte.find(params[:id])
    else
      redirect_to root_path
      flash[:danger] = 'Você não possui permissão para manipular este CT-e.'
    end
  end
end
