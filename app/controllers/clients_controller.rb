# frozen_string_literal: true

class ClientsController < UsersController
  before_action :set_client, only: %w[edit update destroy show]
  rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

  def index
    @clients = Client.accessible_by(current_ability).order(:company_name)
  end

  def new
    @client = Client.new
    @client.build_address
  end
  
  def show; end
  
  def create
    @client = Client.new(params_client)
    @client.address.validate_address = true

    @client.save ? (redirect_to admins_clients_path, notice: 'Cliente cadastrado com sucesso') : (render :new)
  end

  def edit; end

  def update
    @client.address.validate_address = true
    @client.update(params_client) ? (redirect_to admins_clients_path, notice: 'Cliente atualizado com sucesso') : (render :edit)
  end

  def destroy
    @client.destroy ? (redirect_to admins_clients_path, notice: 'Cliente excluído com sucesso') : (render :index)
  end

  private

  def set_client
    if Enterprise.find(current_user.enterprise_id).client_ids.include?(Client.find(params[:id]).id)
      @client = Client.find(params[:id])
    else
      redirect_to root_path
      flash[:danger] = 'Você não tem permissão para editar este cliente.' 
    end
  end

  def params_client
    params.require(:client)
          .permit(:company_name,
                  :document_number,
                  :email,
                  :fantasy_name,
                  :is_active,
                  :observation,
                  :phone_number,
                  :responsible,
                  :telephone_number,
                  address_attributes: Address.permitted_attributes)
          .with_defaults(enterprise_id: current_user.enterprise_id)
  end

  def invalid_foreign_key
    redirect_to clients_index_path
    flash[:danger] = 'Não é possível excluir, pois o cliente possui carga(s) e/ou CT-e(s) vinculado.'
  end
end
