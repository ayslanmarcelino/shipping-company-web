# frozen_string_literal: true

class TruckloadsController < UsersController
  before_action :set_truckload, only: %w[edit update destroy show]
  before_action :set_client, only: %w[new create edit update]
  before_action :set_driver, only: %w[new create edit update]
  rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

  def index
    @truckloads = Truckload.includes(:client)
                           .includes(:cte)
                           .includes(:driver)
                           .includes(:user)
                           .accessible_by(current_ability).order(updated_at: :desc)
  end

  def new
    @truckload = Truckload.new
  end

  def create    
    @truckload = Truckload.new(params_truckload)
    @truckload.validate_all = true
    create_ctes

    if @truckload.save && (@new_cte&.errors&.full_messages&.empty? || @new_cte&.errors&.full_messages.nil?)
      redirect_to(truckloads_path)
      flash[:success] = 'Carga cadastrada com sucesso.'
    else
      render :new
    end
  end

  def edit; end

  def update
    @truckload.validate_all = true
    create_ctes

    if @truckload.update(params_truckload) && (@new_cte&.errors&.full_messages&.empty? || @new_cte&.errors&.full_messages.nil?)
      redirect_to(truckloads_path)
      flash[:success] = 'Carga atualizada com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    if @truckload.destroy
      redirect_to(truckloads_path)
      flash[:success] = 'Carga excluída com sucesso.'
    else
      render :index
    end
  end

  private

  def invalid_foreign_key
    redirect_to truckloads_path
    flash[:danger] = 'Carga com dados vinculados não pode ser excluída.'
  end

  def set_truckload
    if current_user.truckload_ids.include?(Truckload.find(params[:id]).id) ||
       current_user.roles.kind_masters.present? ||
       (current_user.roles.kind_owners.present? &&
        current_user.enterprise_id == Truckload.find(params[:id]).enterprise_id)
      @truckload = Truckload.find(params[:id])
    else
      redirect_to root_path
      flash[:danger] = 'Você não tem permissão para manipular esta carga.'
    end
  end

  def set_client
    @clients = Client.where(enterprise_id: current_user.enterprise.id).order(:company_name)
  end

  def set_driver
    @drivers = Driver.where(enterprise_id: current_user.enterprise.id, is_blocked: false)
  end

  def params_truckload
    params.require(:truckload)
          .permit(:dt_number, :value_driver, :is_agent, :client_id, :user_id, :driver_id)
          .with_defaults(user: current_user, enterprise: current_user.enterprise)
  end

  def create_ctes
    ctes = params.require(:truckload)[:cte]

    if ctes.present?
      params.require(:truckload)[:cte].each do |cte|
        xml = File.read(cte)
        data = Hash.from_xml(xml)
        cte_info = data['cteProc']['CTe']['infCte']

        @new_cte = Cte.new
        @new_cte.cte_id = cte_info['Id'] if cte_info['Id'].present?
        @new_cte.emitted_at = cte_info['ide']['dhEmi'].to_datetime if cte_info['ide']['dhEmi'].present?
        @new_cte.cte_number = cte_info['ide']['nCT'] if cte_info['ide']['nCT'].present?
        @new_cte.value = cte_info['vPrest']['Comp'].first['vComp'].to_f if cte_info['vPrest']['Comp'].first['vComp'].present?
        if cte_info['compl'].present?
          @new_cte.emitter = cte_info['compl']['xEmi'] 
          @new_cte.observation = cte_info['compl']['xObs']
        end
        @new_cte.enterprise = current_user.enterprise
        @new_cte.user = current_user
        @new_cte.truckload = @truckload
        @new_cte.save

        if @new_cte.errors.present?
          @new_cte.errors.full_messages.each do |message|
            flash[:danger] = message
          end
        end
      end
    end
  end
end
