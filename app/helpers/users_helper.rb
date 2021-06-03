module UsersHelper
  def enterprises_collection
    Enterprise.pluck(:company_name, :id)
              .compact
              .sort
  end

  def roles_collection
    User::Role.pluck(:kind_cd)
              .compact
              .uniq
              .sort
  end
end
