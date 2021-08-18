class DriversController < UsersController
  before_action :set_driver, only: %w[show edit update destroy]
  before_action :set_enterprise, only: %w[create new edit update destroy]
  rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

  def index
    @q = Driver.includes(:enterprise)
               .includes(:person)
               .accessible_by(current_ability)
               .page(params[:page])
               .ransack(params[:q])

    @drivers = @q.result(distinct: false)
  end

  def new
    @driver = Driver.new
    @driver.build_person
    @driver.person.build_address
  end

  def show; end

  def create
    @driver = Driver.new(params_driver)
    @driver.validate_all = true
    @driver.person.validate_all = true
    @driver.person.address.validate_address = true

    if @driver.save
      redirect_to drivers_path
      flash[:success] = 'Motorista cadastrado com sucesso.'
    else
      render :new
    end
  end

  def edit; end

  def update
    @driver.validate_all = true
    @driver.person.validate_all = true
    @driver.person.address.validate_address = true

    if @driver.update(params_driver)
      redirect_to drivers_path
      flash[:success] = 'Motorista atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    if @driver.destroy && @driver.person.destroy
      redirect_to drivers_path
      flash[:success] = 'Motorista excluído com sucesso.'
    else
      render :index
    end
  end

  private

  def invalid_foreign_key
    redirect_to drivers_path
    flash[:danger] = 'Motorista com dados vinculados não pode ser excluído.'
  end

  def set_driver
    can_view_driver = true if current_user.roles.kind_masters.present? ||
                              (current_user.roles.kind_owners.present? ||
                                current_user.enterprise_id == Driver.find(params[:id]).enterprise_id)
    if can_view_driver
      @driver = Driver.find(params[:id])
    else
      redirect_to root_path
      flash[:danger] = 'Você não tem permissão para manipular este motorista.'
    end
  end

  def set_enterprise
    @enterprise = if current_user.roles.kind_masters.present?
                    Enterprise.all
                  else
                    Enterprise.where(id: current_user.enterprise_id)
                  end
  end

  def params_driver
    params.require(:driver)
          .permit(:enterprise_id,
                  :cnh_expires_at,
                  :cnh_issuing_body,
                  :cnh_number,
                  :cnh_record,
                  :cnh_type,
                  :is_employee,
                  :is_blocked,
                  person_attributes: [User::Person.permitted_attributes,
                                      address_attributes: Address.permitted_attributes,
                                      bank_accounts_attributes: BankAccount.permitted_attributes])
  end
end
