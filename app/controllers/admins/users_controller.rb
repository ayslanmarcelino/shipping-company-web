# frozen_string_literal: true

module Admins
  class UsersController < AdminsController
    before_action :verify_password, only: %w[update]
    before_action :set_user, only: %w[edit update destroy]
    before_action :set_enterprise, only: %w[create new edit update destroy]

    def index
      @q = User.accessible_by(current_ability).ransack(params[:q])
      @users = @q.result(distinct: true)
    end

    def new
      @user = User.new
    end

    def show; end

    def create
      @user = User.new(params_user)

      if @user.save!
        redirect_to admins_users_path
        flash[:success] = 'Usuário cadastrado com sucesso.'
      else
        render :new
      end
    end

    def edit; end

    def update
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
      @user = User.find(params[:id])
    end

    def set_enterprise
      if current_user.roles.kind_masters.present?
        @enterprise = Enterprise.all
      else
        @enterprise = Enterprise.where(id: current_user.enterprise_id)
      end
    end

    def params_user
      
      binding.pry
      
      params.require(:user)
            .permit(:document_number,
                    :email,
                    :first_name,
                    :is_active,
                    :last_name,
                    :nickname,
                    :enterprise_id,
                    :password,
                    :password_confirmation)
    end

    def verify_password
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].extract!(:password, :password_confirmation)
      end
    end
  end
end
