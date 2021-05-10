# frozen_string_literal: true

module Admins
  class UsersController < AdminsController
    before_action :verify_password, only: %w[update]
    before_action :set_user, only: %w[edit update destroy]

    def index   
      @q = User.where(enterprise_id: current_user.enterprise_id)
               .ransack(params[:q])
      @users = @q.result(distinct: true)
    end

    def new
      @user = User.new
    end

    def show; end

    def create
      @user = User.new(params_user)

      if @user.save
        redirect_to admins_users_path
        flash[:success] = 'Usuário cadastrado com sucesso.'
      else
        render :new
      end
    end

    def edit; end

    def update
      
      binding.pry
      
      if @user.update(params_user)
        redirect_to admins_users_path
        flash[:success] = 'Usuário atualizado com sucesso.'
      else
        render :edit
      end
    end

    def destroy
      if @user.destroy
        redirect_to admins_users_path
        flash[:success] = 'Usuário excluído com sucesso.'
      else
        render :index
      end
    end

    private

    def set_user
      if current_user.enterprise_id == User.find(params[:id]).enterprise_id
        @user = User.find(params[:id])
      else
        redirect_to root_path
        flash[:danger] = 'Você não tem permissão para editar este usuário.' 
      end
    end

    def params_user
      params.require(:user)
            .permit(:document_number, :email, :first_name, :is_active, :is_admin, :last_name, :nickname,
                    :password, :password_confirmation)
            .with_defaults(enterprise_id: current_user.enterprise_id)
    end

    def verify_password
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].extract!(:password, :password_confirmation)
      end
    end
  end
end
