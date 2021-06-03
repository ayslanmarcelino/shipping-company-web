class Ability
  include CanCan::Ability
  attr_reader :user

  def initialize(user)
    return unless user

    @user = user
    roles = @user.roles

    roles.each do |role|
      PerEnterpriseAbility.new(self, enterprise: role.enterprise, user: @user).compile(role.kind)
    end
  end

  class PerEnterpriseAbility
    def initialize(ability, enterprise:, user:)
      @ability = ability
      @enterprise = enterprise
      @user = user
    end

    def compile(kind)
      case kind
      when :master
        can(:manage, :all)
      when :owner
        owner_abilities
      when :employee
        employee_abilities
      # when :financial
      #   can(:read, :all)
      end
    end

    private

    def can(*a)
      @ability.can(*a)
    end

    def cannot(*a)
      @ability.cannot(*a)
    end

    def owner_abilities
      can(:manage, Truckload, enterprise: @enterprise)
      can(:manage, Cte, enterprise: @enterprise)
      can(:manage, Client, enterprise: @enterprise)
      can(:manage, User, enterprise: @enterprise)
      # can(:manage, Role, enterprise_id: @enterprise.id)
    end

    def employee_abilities
      
      # binding.pry
      
      can(:manage, Truckload, user: @user)
      can(:manage, Cte, user: @user)
    end
  end
end
