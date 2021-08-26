class AgentsController < UsersController
  before_action :set_agent, only: %w[show edit update destroy]
  before_action :set_enterprise, only: %w[create new edit update destroy]
  rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

  def index
    @q = Agent.includes(:person, :enterprise).accessible_by(current_ability)
              .page(params[:page])
              .ransack(params[:q])

    @agents = @q.result(distinct: false)
  end

  def new
    @agent = Agent.new
    @agent.build_person
    @agent.person.build_address
  end

  def show; end

  def create
    @agent = Agent.new(params_agent)
    @agent.person.validate_all = true
    @agent.person.address.validate_address = true

    if @agent.save
      redirect_to(agents_path)
      flash[:success] = 'Agenciador cadastrado com sucesso.'
    else
      render :new
    end
  end

  def edit; end

  def update
    @agent.person.validate_all = true
    @agent.person.address.validate_address = true

    if @agent.update(params_agent)
      redirect_to(agents_path)
      flash[:success] = 'Agente atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    bank_accounts = BankAccount.where(person: @agent.person)

    if @agent.destroy && bank_accounts.destroy_all && @agent.person.destroy
      redirect_to(agents_path)
      flash[:success] = 'Agenciador excluído com sucesso.'
    else
      render :index
    end
  end

  private

  def invalid_foreign_key
    redirect_to(agents_path)
    flash[:danger] = 'Agenciador dados vinculados não pode ser excluído.'
  end

  def set_agent
    can_view_agent = true if current_user.roles.kind_masters.present? ||
                             current_user.enterprise_id == Agent.find(params[:id]).enterprise_id
    if can_view_agent
      @agent = Agent.find(params[:id])
    else
      redirect_to(root_path)
      flash[:danger] = 'Você não possui permissão para manipular este agenciador.'
    end
  end

  def set_enterprise
    @enterprise = if current_user.roles.kind_masters.present?
                    Enterprise.all
                  else
                    Enterprise.where(id: current_user.enterprise_id)
                  end
  end

  def params_agent
    params.require(:agent)
          .permit(:enterprise_id,
                  person_attributes: [Person.permitted_attributes,
                                      address_attributes: Address.permitted_attributes,
                                      bank_accounts_attributes: BankAccount.permitted_attributes])
  end
end
