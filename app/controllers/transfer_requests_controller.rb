# frozen_string_literal: true

class TransferRequestsController < UsersController
  before_action :set_transfer_request, only: %w[show destroy update]
  before_action :set_truckload, only: %w[show create new destroy update]
  before_action :set_agent, only: %w[show create new destroy update]
  before_action :set_driver, only: %w[show create new destroy update]
  before_action :set_bank_account, only: %w[show create new destroy update]

  def index
    @q = TransferRequest.includes([bank_account: :person], :truckload, :user, :enterprise)
                        .accessible_by(current_ability)
                        .page(params[:page])
                        .ransack(params[:q])

    @transfer_requests = @q.result(distinct: false)
  end

  def new
    @transfer_request = TransferRequest.new
  end

  def create
    @transfer_request = TransferRequest.new(params_transfer_request)

    if @transfer_request.save
      redirect_to(transfer_requests_path)
      flash[:success] = 'Solicitação de transferência cadastrada com sucesso.'
    else
      render :new
    end
  end

  def update
    params_update_transfer_request = case params.require(:commit)
                                     when 'Aprovar'
                                       params_approve_transfer_request
                                     when 'reject'
                                       params_reject_transfer_request
                                     end

    if params_update_transfer_request == params_approve_transfer_request
      notice = 'Solicitação de transferência aprovada com sucesso.'
      @transfer_request.status_cd = 'approved'
      @transfer_request.balance_value_truckload -= @transfer_request.value
    elsif params_update_transfer_request == params_reject_transfer_request
      notice = 'Solicitação de transferência rejeitada com sucesso.'
    end

    return unless @transfer_request.update(params_update_transfer_request)

    redirect_to(pending_transfer_requests_path)
    flash[:success] = notice
  end

  def destroy
    can_destroy_transfer_request = true if current_user.roles.kind_masters.present? ||
                                           TransferRequest.find(params[:id]).user == current_user

    if TransferRequest.find(params[:id]).status_cd != 'pending'
      redirect_to(transfer_requests_path)
      flash[:danger] = 'Você não pode deletar solicitação que não esteja pendente.'
      return
    end

    if can_destroy_transfer_request
      if @transfer_request.destroy
        redirect_to(transfer_requests_path)
        flash[:success] = 'Solicitação de transferência excluída com sucesso.'
      else
        render :index
      end
    else
      redirect_to(transfer_requests_path)
      flash[:danger] = 'Você não pode deletar a solicitação de transferência de terceiros.'
    end
  end

  def truckload_information
    @truckload = Truckload.find(params[:id])
    @balance_value_truckload = @truckload.transfer_requests
                                         .where(status_cd: 'approved')
                                         .last
                                         &.balance_value_truckload || @truckload.value_driver
    @formatted_balance_value_truckload = @balance_value_truckload.to_currency
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
                    balance_value_truckload: @balance_value_truckload,
                    formatted_balance_value_truckload: @formatted_balance_value_truckload,
                    agent_bank_account: @agent_bank_account,
                    driver_bank_account: @driver_bank_account
                  }

    render json: information
  end

  def pending
    @search_params = params[:q]
    transfer_request = TransferRequest.includes([bank_account: :person], :truckload, :user, :enterprise)
    @q = if current_user.roles.kind_masters.present?
           transfer_request.where(status_cd: :pending).ransack(@search_params)
         else
           transfer_request.where(status_cd: :pending, enterprise: current_user.enterprise).ransack(@search_params)
         end
    @transfer_requests = @q.result.page(params[:page]).per(15)
    @pending_transfer_request_count = @q.result.count
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

  def params_approve_transfer_request
    params.require(:transfer_request)
          .permit(:voucher)
          .with_defaults(updated_by_id: current_user.id)
  end

  def params_reject_transfer_request
    nil
  end

  def params_transfer_request
    truckload = Truckload.find(params.require(:transfer_request)[:truckload_id])
    driver = Driver.find(truckload.driver_id) if params.require(:transfer_request)[:driver] == '1'
    agent = Agent.find(truckload.agent_id) if params.require(:transfer_request)[:agent] == '1'
    balance_value_truckload = truckload.transfer_requests.where(status_cd: 'approved').last&.balance_value_truckload ||
                              truckload.value_driver

    params.require(:transfer_request)
          .permit(:value,
                  :observation,
                  :type_cd,
                  :method_cd,
                  :truckload_id,
                  :bank_account_id)
          .with_defaults(enterprise: current_user.enterprise,
                         driver: driver,
                         agent: agent,
                         user: current_user,
                         balance_value_truckload: balance_value_truckload)
  end
end
