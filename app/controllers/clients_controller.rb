# frozen_string_literal: true

class ClientsController < UsersController
  before_action :set_client, only: %w[edit update destroy show]
  rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

  def index
    return if cannot?(:read, Client) && unauthorized_redirect

    @q = Client.includes(:address, :enterprise)
               .accessible_by(current_ability)
               .page(params[:page])
               .ransack(params[:q])

    @clients = @q.result(distinct: false)
  end

  def show
    return if cannot?(:read, Client) && unauthorized_redirect
  end

  def new
    return if cannot?(:create, Client) && unauthorized_redirect

    @client = Client.new
    @client.build_address
  end

  def create
    return if cannot?(:create, Client) && unauthorized_redirect

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

  def edit
    return if cannot?(:update, Client) && unauthorized_redirect
  end

  def update
    return if cannot?(:update, Client) && unauthorized_redirect

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
    return if cannot?(:destroy, Client) && unauthorized_redirect

    if @client.destroy
      redirect_to(clients_path)
      flash[:success] = 'Cliente excluído com sucesso'
    else
      render :index
    end
  end

  private

  def unauthorized_redirect
    redirect_to(root_path)
    flash[:danger] = 'Você não possui permissão para realizar esta ação.'
  end

  def set_client
    if Enterprise.find(current_user.enterprise_id).client_ids.include?(Client.find(params[:id]).id) || current_user.roles.kind_masters.present?
      @client = Client.find(params[:id])
    else
      redirect_to root_path
      flash[:danger] = 'Você não possui permissão para editar este cliente.'
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
