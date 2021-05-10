class SessionsController < Devise::SessionsController

  protected
  
  def after_sign_in_path_for(resource)
    if (resource.is_a?(User) && !resource.is_active?)
      sign_out resource
      flash[:danger] = 'Sua conta está inativa. Para mais informações, entre em contato com o administrador da empresa.'
      root_path
    else
      super
    end

    if current_user.present? && !current_user.enterprise.is_active?
      sign_out(current_user)
      flash[:danger] = 'Sua empresa está inativa. Para mais informações, entre em contato com o suporte.'
      root_path
    else
      super
    end
  end
end
