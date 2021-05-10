# frozen_string_literal: true

module SuperAdmins
  class UsersController < SuperAdminsController
    before_action :verify_password, only: %w[update]
    before_action :set_user, only: %w[edit update destroy]
    before_action :set_enterprise, only: %w[create new edit update destroy]

    def index
      @q = User.ransack(params[:q])
      @users = @q.result(distinct: true)
    end

    def new
      @user = User.new
    end

    def show; end

    def create
      @user = User.new(params_user)

      if @user.save
        redirect_to super_admins_users_path
        flash[:success] = 'Usuário cadastrado com sucesso.'
      else
        render :new
      end
    end

    def edit; end

    def update
      if @user.update(params_user)
        redirect_to super_admins_users_path
        flash[:success] = 'Usuário atualizado com sucesso.'
      else
        render :edit
      end
    end

    def destroy
      if @user.destroy
        redirect_to super_admins_users_path
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
      @enterprise = Enterprise.all
    end

    def params_user
      params.require(:user)
            .permit(:document_number, :email, :first_name, :is_active, :is_admin, :is_super_admin, :last_name,
                    :nickname, :enterprise_id, :password, :password_confirmation)
    end

    def verify_password
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].extract!(:password, :password_confirmation)
      end
    end
  end
end
