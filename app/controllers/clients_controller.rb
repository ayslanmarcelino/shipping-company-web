# frozen_string_literal: true

class ClientsController < UsersController
  before_action :set_client, only: %w[edit update destroy show]
  rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

  def index
    @q = Client.includes(:address).accessible_by(current_ability).order(:company_name).ransack(params[:q])

    @clients = @q.result(distinct: false)
  end

  def new
    @client = Client.new
    @client.build_address
  end

  def show; end

  def create
    @client = Client.new(params_client)
    @client.validate_all = true
    @client.address.validate_address = true

    if @client.save
      redirect_to(clients_path)
      flash[:success] = 'Cliente cadastrado com sucesso'
    else
      render :new
    end
  end

  def edit; end

  def update
    @client.validate_all = true
    @client.address.validate_address = true
    if @client.update(params_client)
      redirect_to(clients_path)
      flash[:success] = 'Cliente atualizado com sucesso'
    else
      render :edit
    end
  end

  def destroy
    if @client.destroy
      redirect_to(clients_path)
      flash[:success] = 'Cliente excluído com sucesso'
    else
      render :index
    end
  end

  private

  def set_client
    if Enterprise.find(current_user.enterprise_id).client_ids.include?(Client.find(params[:id]).id) || current_user.roles.kind_masters.present?
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
    flash[:danger] = 'Cliente com dados vinculados não pode ser excluído.'
  end
end
