# frozen_string_literal: true

class TruckloadsController < UsersController
  before_action :set_truckload, only: %w[edit update destroy show]
  before_action :set_client, only: %w[new create edit]
  rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

  def index
    @truckloads = Truckload.accessible_by(current_ability).order(updated_at: :desc)
  end

  def new
    @truckload = Truckload.new
  end

  def create
    @truckload = Truckload.new(params_truckload)

    @truckload.save ? (redirect_to truckloads_path, notice: 'Carga cadastrada com sucesso') : (render :new)
  end

  def edit; end

  def update
    @truckload.update(params_truckload) ? (redirect_to truckloads_path, notice: 'Carga atualizada com sucesso') : (render :edit)
  end

  def destroy
    @truckload.destroy ? (redirect_to truckloads_path, notice: 'Carga excluída com sucesso') : (render :index)
  end

  private

  def invalid_foreign_key
    redirect_to truckloads_path
    flash[:danger] = 'Carga com CT-e vinculado não pode ser excluída.'
  end

  def set_truckload
    if current_user.truckload_ids.include?(Truckload.find(params[:id]).id) || current_user.roles.kind_masters.present?
      @truckload = Truckload.find(params[:id])
    else
      redirect_to root_path
      flash[:danger] = 'Você não tem permissão para manipular esta carga.'
    end
  end

  def set_client
    @clients = Client.where(enterprise_id: current_user.enterprise.id).order(:company_name)
  end

  def params_truckload
    params.require(:truckload)
          .permit(:dt_number, :value_driver, :is_agent, :client_id, :user_id)
          .with_defaults(user: current_user, enterprise: current_user.enterprise)
  end
end
