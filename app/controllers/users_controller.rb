# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :verify_password, only: %w[update]
  before_action :set_user, only: %w[edit update destroy]
  before_action :set_enterprise, only: %w[create new edit update destroy]

  def index
    @q = User.includes(:enterprise)
             .includes(:roles)
             .includes(:person)
             .accessible_by(current_ability)
             .ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def new
    @user = User.new
    @user.build_person
    @user.person.build_address
  end

  def show; end

  def create
    @user = User.new(params_user)

    if @user.save
      redirect_to users_path
      flash[:success] = 'Usuário cadastrado com sucesso.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(params_user)
      redirect_to users_path
      flash[:success] = 'Usuário atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_path
      flash[:success] = 'Usuário excluído com sucesso.'
    else
      render :index
    end
  end

  private

  def set_user
    can_view_user = true if current_user.roles.kind_masters.present? ||
                            current_user.id == User.find(params[:id]).id ||
                            (current_user.roles.kind_owners.present? &&
                              current_user.enterprise_id == User.find(params[:id]).enterprise_id)
    if can_view_user
      @user = User.find(params[:id])
    else
      redirect_to root_path
      flash[:danger] = 'Você não tem permissão para manipular este usuário.'
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
                  person_attributes: [User::Person.permitted_attributes,
                                      address_attributes: Address.permitted_attributes])
  end

  def verify_password
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].extract!(:password, :password_confirmation)
    end
  end
end
