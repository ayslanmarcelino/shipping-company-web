module UsersHelper
  def enterprises_collection
    Enterprise.pluck(:company_name, :id)
              .compact
              .sort
  end

  def users_collection
    @users = []

    users = if user_master?(current_user)
              User.all
            else
              User.where(enterprise: current_user.enterprise)
            end

    users.each do |user|
      @users << ["#{user.person.first_name} #{user.person.last_name} | #{user.email}", user.id]
    end

    @users.sort
  end
end
