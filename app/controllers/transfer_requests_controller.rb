# frozen_string_literal: true

class TransferRequestsController < UsersController
  before_action :set_transfer_request, only: %w[show destroy]
  before_action :set_truckload, only: %w[create new destroy]
  before_action :set_agent, only: %w[create new destroy]
  before_action :set_driver, only: %w[create new destroy]
  before_action :set_bank_account, only: %w[create new destroy]

  def index
    @q = TransferRequest.accessible_by(current_ability)
                        .page(params[:page])
                        .ransack(params[:q])

    @transfer_requests = @q.result(distinct: false)
  end

  def new
    @transfer_request = TransferRequest.new
  end

  def show; end

  def create
    @transfer_request = TransferRequest.new(params_transfer_request)

    if @transfer_request.save
      redirect_to transfer_requests_path
      flash[:success] = 'Solicitação de transferência cadastrada com sucesso.'
    else
      render :new
    end
  end

  def destroy
    if @transfer_request.destroy
      redirect_to transfer_requests_path
      flash[:success] = 'Solicitação de transferência excluída com sucesso.'
    else
      render :index
    end
  end

  def truckload_information
    @truckload = Truckload.find(params[:id])
    @truckload_value_driver = @truckload.value_driver.to_currency
    @agent = @truckload&.agent&.person || []
    @driver = @truckload.driver.person
    @driver_bank_account = @driver.bank_accounts
    @agent_bank_account = if @agent.present?
                            @agent.bank_accounts
                          else
                            []
                          end
    information = {
                    truckload: @truckload,
                    truckload_value_driver: @truckload_value_driver,
                    agent_bank_account: @agent_bank_account,
                    driver_bank_account: @driver_bank_account
                  }

    render json: information
  end

  def pending
    @search_params = params[:q]
    @q = TransferRequest.where(status_cd: :pending).ransack(@search_params)
    @transfer_requests = @q.result.page(params[:page]).per(50)
  end

  def approve
  end

  def reject
  end

  private

  def set_transfer_request
    can_view_transfer_request = true if current_user.roles.kind_masters.present? ||
                                        current_user.enterprise_id == TransferRequest.find(params[:id]).enterprise_id
    if can_view_transfer_request
      @transfer_request = TransferRequest.find(params[:id])
    else
      redirect_to root_path
      flash[:danger] = 'Você não tem permissão para manipular esta solicitação de transferência.'
    end
  end

  def set_truckload
    @truckloads = if current_user.roles.kind_masters.present?
                    Truckload.all
                  else
                    Truckload.where(enterprise: current_user.enterprise, user: current_user)
                  end
  end

  def set_agent
    @agents = if current_user.roles.kind_masters.present?
                Agent.all
              else
                Agent.where(enterprise: current_user.enterprise)
              end
  end

  def set_driver
    @drivers = if current_user.roles.kind_masters.present?
                 Driver.all
               else
                 Driver.where(enterprise: current_user.enterprise)
               end
  end

  def set_bank_account
    @bank_accounts = if current_user.roles.kind_masters.present?
                       BankAccount.all
                      else
                        BankAccount.all
                     end
  end

  def params_transfer_request
    truckload = Truckload.find(params.require(:transfer_request)[:truckload_id])
    driver = Driver.find(truckload.driver_id) if params.require(:transfer_request)[:driver] == '1'
    agent = Agent.find(truckload.agent_id) if params.require(:transfer_request)[:agent] == '1'

    params.require(:transfer_request)
          .permit(:value,
                  :type_cd,
                  :method_cd,
                  :truckload_id,
                  :bank_account_id)
          .with_defaults(enterprise: current_user.enterprise,
                         driver: driver,
                         agent: agent,
                         user: current_user)
  end
end
