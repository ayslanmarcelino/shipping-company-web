module UsersHelper
  def enterprises_collection
    Enterprise.pluck(:company_name, :id)
              .compact
              .sort
  end

  def users_collection
    if current_user.roles.kind_masters.present?
      User.pluck(:email, :id)
          .compact
          .sort
    else
      User.where(enterprise: current_user.enterprise)
          .pluck(:email, :id)
          .compact
          .sort
    end
  end
end
