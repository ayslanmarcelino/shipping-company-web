module UsersHelper
  def enterprises_collection
    Enterprise.pluck(:company_name, :id)
              .compact
              .sort
  end

  def users_collection
    User.pluck(:email, :id)
        .compact
        .sort
  end
end
