# frozen_string_literal: true

class User::RolesController < AdminsController
  before_action :set_user_role, only: %w[edit update destroy show]
  before_action :set_user, only: %w[new create edit]
  before_action :set_enterprise, only: %w[new create edit]

  def index
    @user_roles = User::Role.accessible_by(current_ability)
  end

  def new
    @user_role = User::Role.new
  end

  def create
    @user_role = User::Role.new(params_user_role)

    if can?(:create, User::Role)
      @user_role.save ? (redirect_to user_roles_path, notice: 'Regra de usuário cadastrada com sucesso') : (render :new)
    else
      redirect_to(user_roles_path)
      flash[:danger] = 'Você não tem permissão para realizar esta ação.'
    end
  end

  def edit; end

  def update
    if can?(:update, User::Role)
      @user_role.update(params_user_role) ? (redirect_to(user_roles_path, notice: 'Regra de usuário atualizada com sucesso')) : (render :edit)
    else
      redirect_to(user_roles_path)
      flash[:danger] = 'Você não tem permissão para realizar esta ação.'
    end
  end

  def destroy
    if can?(:delete, User::Role)
      @user_role.destroy ? (redirect_to user_roles_path, notice: 'Regra de usuário excluída com sucesso') : (render :index)
    else
      redirect_to(user_roles_path)
      flash[:danger] = 'Você não tem permissão para realizar esta ação.'
    end
  end

  private

  def set_user_role
    if current_user.enterprise_id == User::Role.find(params[:id]).enterprise_id || current_user.roles.kind_masters.present?
      @user_role = User::Role.find(params[:id])
    else
      redirect_to root_path
      flash[:danger] = 'Você não tem permissão para manipular esta regra de usuário.'
    end
  end

  def set_user
    if current_user.roles.kind_masters.present?
      @users = User.all
    else
      @users = User.where(enterprise_id: current_user.enterprise_id)
    end
  end

  def set_enterprise
    @enterprises = if current_user.roles.kind_masters.present?
                      Enterprise.all
                    else
                      Enterprise.where(id: current_user.enterprise_id)
                    end
  end

  def params_user_role
    params.require(:user_role)
          .permit(:kind_cd, :enterprise_id, :user_id)
  end
end
