# frozen_string_literal: true

class TruckloadsController < UsersController
  before_action :set_truckload, only: %w[edit update destroy show]
  before_action :set_client, only: %w[new create edit update]
  before_action :set_driver, only: %w[new create edit update]
  before_action :set_agent, only: %w[new create edit update]
  rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

  def index
    @q = Truckload.includes(:ctes, [driver: :person], [client: :address])
                  .includes([user: :person])
                  .accessible_by(current_ability)
                  .page(params[:page])
                  .ransack(params[:q])

    @truckloads = @q.result(distinct: false)
  end

  def new
    @truckload = Truckload.new
  end

  def create
    @truckload = Truckload.new(params_truckload)
    @truckload.validate_all = true
    @truckload.balance_value_driver = @truckload.value_driver
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

  def set_agent
    @agents = Agent.where(enterprise_id: current_user.enterprise.id)
  end

  def params_truckload
    params.require(:truckload)
          .permit(:dt_number, :value_driver, :is_agent, :user_id, :driver_id, :agent_id)
          .with_defaults(user: current_user, enterprise: current_user.enterprise)
  end

  def create_ctes
    ctes = params.require(:truckload)[:cte]

    if ctes.present?
      params.require(:truckload)[:cte].reverse.each do |cte|
        xml_cte = File.read(cte)
        data_xml = Hash.from_xml(xml_cte)
        @cte_info = data_xml['cteProc']['CTe']['infCte']
        @client_document_number = @cte_info['rem']['CNPJ']
        @client = Client.find_or_initialize_by(document_number: @client_document_number, enterprise: current_user.enterprise)
        @emitted_enterprise = current_user.enterprise.document_number == @cte_info['emit']['CNPJ']

        if @client.new_record?
          @address = @client.build_address
          @client_address = @cte_info['rem']['enderReme']
          create_address
          create_client
        end

        @truckload.client = @client
        @truckload.save

        create_new_cte

        if @new_cte.errors.present?
          @new_cte.errors.full_messages.each do |message|
            flash[:danger] = message
          end
        end
      end
    end
  end

  def create_address
    @address.city = @client_address['xMun']
    @address.city_code = @client_address['cMun']
    @address.complement = @client_address['xCpl']
    @address.country = @client_address['xPais']
    @address.country_code = @client_address['cPais']
    @address.neighborhood = @client_address['xBairro']
    @address.number = @client_address['nro']
    @address.state = @client_address['UF']
    @address.street = @client_address['xLgr']
    @address.zip_code = @client_address['CEP']
    @address.save
  end

  def create_client
    @client.address = @address
    @client.enterprise = current_user.enterprise
    @client.company_name = @cte_info['rem']['xNome']
    @client.document_number = @client_document_number
    @client.state_tax_number = @cte_info['rem']['IE']
    @client.save
  end

  def create_new_cte
    @new_cte = Cte.new
    destiny_address = @cte_info['dest']['enderDest']

    @new_cte.emitted_by_enterprise = @emitted_enterprise
    @new_cte.cte_id = @cte_info['Id'] if @cte_info['Id'].present?
    @new_cte.company_name_emitter = @cte_info['emit']['xNome']
    @new_cte.fantasy_name_emitter = @cte_info['emit']['xFant']
    @new_cte.document_number_emitter = @cte_info['emit']['CNPJ']
    @new_cte.state_tax_number_emitter = @cte_info['emit']['IE']

    @new_cte.destiny = @cte_info['dest']['xNome']
    @new_cte.destiny_city = destiny_address['xMun']
    @new_cte.destiny_city_code = destiny_address['cMun']
    @new_cte.destiny_complement = destiny_address['xCpl']
    @new_cte.destiny_country = destiny_address['xPais']
    @new_cte.destiny_country_code = destiny_address['cPais']
    @new_cte.destiny_neighborhood = destiny_address['xBairro']
    @new_cte.destiny_number = destiny_address['nro']
    @new_cte.destiny_state = destiny_address['UF']
    @new_cte.destiny_street = destiny_address['xLgr']
    @new_cte.destiny_zip_code = destiny_address['CEP']

    @new_cte.emitted_at = @cte_info['ide']['dhEmi'].to_datetime if @cte_info['ide']['dhEmi'].present?
    @new_cte.cte_number = @cte_info['ide']['nCT'] if @cte_info['ide']['nCT'].present?
    @new_cte.value = @cte_info['vPrest']['vTPrest'].to_f if @cte_info['vPrest']['vTPrest'].present?
    if @cte_info['compl'].present?
      @new_cte.emitter = @cte_info['compl']['xEmi'] if @emitted_enterprise
      @new_cte.observation = @cte_info['compl']['xObs']
    end
    @new_cte.client = @client
    @new_cte.enterprise = current_user.enterprise
    @new_cte.user = current_user
    @new_cte.truckload = @truckload
    @new_cte.save
  end
end
