module UsersHelper
  def enterprises_collection
    Enterprise.pluck(:company_name, :id)
              .compact
              .sort
  end
end
