# frozen_string_literal: true

class User::RolesController < AdminsController
  before_action :set_user_role, only: %w[edit update destroy show]
  before_action :set_user, only: %w[new create edit update]
  before_action :set_enterprise, only: %w[new create edit update]

  def index
    @q = User::Role.includes(:user)
                   .includes(:enterprise)
                   .includes(user: :person)
                   .accessible_by(current_ability)
                   .page(params[:page])
                   .ransack(params[:q])

    @user_roles = @q.result(distinct: false)
  end

  def new
    @user_role = User::Role.new
  end

  def create
    @user_role = User::Role.new(params_user_role)
    @user_role.validate_all = true

    if can?(:create, User::Role)
      if @user_role.save
        redirect_to(user_roles_path)
        flash[:success] = 'Regra de usuário cadastrada com sucesso.'
      else
        render :new
      end
    else
      redirect_to(user_roles_path)
      flash[:danger] = 'Você não possui permissão para realizar esta ação.'
    end
  end

  def edit; end

  def update
    @user_role.validate_all = true

    if can?(:update, User::Role)
      if @user_role.update(params_user_role)
        redirect_to(user_roles_path)
        flash[:sucess] = 'Regra de usuário atualizada com sucesso.'
      else
        render :edit
      end
    else
      redirect_to(user_roles_path)
      flash[:danger] = 'Você não possui permissão para realizar esta ação.'
    end
  end

  def destroy
    if can?(:delete, User::Role)
      if @user_role.destroy
        redirect_to user_roles_path
        flash[:success] = 'Regra de usuário excluída com sucesso.'
      else
        render :index
      end
    else
      redirect_to(user_roles_path)
      flash[:danger] = 'Você não possui permissão para realizar esta ação.'
    end
  end

  private

  def set_user_role
    if current_user.enterprise_id == User::Role.find(params[:id]).enterprise_id || current_user.roles.kind_masters.present?
      @user_role = User::Role.find(params[:id])
    else
      redirect_to root_path
      flash[:danger] = 'Você não possui permissão para manipular esta regra de usuário.'
    end
  end

  def set_user
    @users = if current_user.roles.kind_masters.present?
               User.where(is_active: true)
             else
               @users = User.where(enterprise_id: current_user.enterprise_id, is_active: true)
             end
  end

  def set_enterprise
    @enterprises = if current_user.roles.kind_masters.present?
                     Enterprise.where(is_active: true)
                   else
                     Enterprise.where(id: current_user.enterprise_id, is_active: true)
                   end
  end

  def params_user_role
    params.require(:user_role)
          .permit(:kind_cd, :enterprise_id, :user_id)
  end
end
