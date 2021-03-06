# frozen_string_literal: true

class Admins::UsersController < AdminsController
  before_action :verify_password, only: %w[update]
  before_action :set_user, only: %w[show edit update destroy]
  before_action :set_enterprise, only: %w[create new edit update destroy]
  rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

  def index
    return if cannot?(:read, User) && unauthorized_redirect

    @q = User.includes(:enterprise)
             .includes(:roles)
             .includes(:person)
             .accessible_by(current_ability)
             .page(params[:page])
             .ransack(params[:q])

    @users = @q.result(distinct: true)
  end

  def show
    return if cannot?(:read, User) && unauthorized_redirect
  end

  def new
    return if cannot?(:create, User) && unauthorized_redirect

    @user = User.new
    @user.build_person
    @user.person.build_address
  end

  def create
    return if cannot?(:create, User) && unauthorized_redirect

    @user = User.new(params_user)
    @user.person.validate_access_data = true

    if @user.save
      redirect_to admins_users_path
      flash[:success] = 'Usuário cadastrado com sucesso.'
    else
      render :new
    end
  end

  def edit
    return if cannot?(:update, User) && unauthorized_redirect
  end

  def update
    return if cannot?(:update, User) && unauthorized_redirect

    @user.validate_all = true
    @user.person.validate_all = true
    @user.person.address.validate_address = true

    if @user.update(params_user)
      if current_user.roles.kind_masters.present? ||
         current_user.roles.kind_owners.present?
        redirect_to(admins_users_path)
      else
        redirect_to(root_path)
      end

      flash[:success] = 'Usuário atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    return if cannot?(:destroy, User) && unauthorized_redirect

    if @user.destroy && @user.person.destroy
      redirect_to admins_users_path
      flash[:success] = 'Usuário excluído com sucesso.'
    else
      render :index
    end
  end

  private

  def unauthorized_redirect
    redirect_to(root_path)
    flash[:danger] = 'Você não possui permissão para realizar esta ação.'
  end

  def invalid_foreign_key
    redirect_to admins_users_path
    flash[:danger] = 'Usuário com dados vinculados não pode ser excluído.'
  end

  def set_user
    can_view_user = true if current_user.roles.kind_masters.present? ||
                            current_user.id == User.find(params[:id]).id ||
                            (current_user.roles.kind_owners.present? &&
                              current_user.enterprise_id == User.find(params[:id]).enterprise_id)
    if can_view_user
      @user = User.find(params[:id])
    else
      redirect_to root_path
      flash[:danger] = 'Você não possui permissão para manipular este usuário.'
    end
  end

  def set_enterprise
    @enterprise = if current_user.roles.kind_masters.present?
                    Enterprise.all
                  else
                    Enterprise.where(id: current_user.enterprise_id)
                  end
  end

  def params_user
    params.require(:user)
          .permit(:email,
                  :is_active,
                  :enterprise_id,
                  :password,
                  :password_confirmation,
                  person_attributes: [Person.permitted_attributes,
                                      address_attributes: Address.permitted_attributes])
  end

  def verify_password
    if params[:user].present?
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].extract!(:password, :password_confirmation)
      end
    end
  end
end
