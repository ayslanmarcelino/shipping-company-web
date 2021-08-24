class Ability
  include CanCan::Ability
  attr_reader :user

  def initialize(user)
    return unless user

    @user = user
    roles = @user.roles

    roles.each do |role|
      PerEnterpriseAbility.new(self, enterprise: @user.enterprise, user: @user).compile(role.kind)
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
      when :operational
        operational_abilities
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
      can(:manage, User::Role, enterprise: @enterprise)
      can(:manage, Driver, enterprise: @enterprise)
      can(:manage, Agent, enterprise: @enterprise)
      can(:manage, TransferRequest, enterprise: @enterprise)
      can(%i[approve reject], TransferRequest, enterprise: @enterprise)
      cannot(:update, Truckload)
      cannot(:update, Cte)
    end

    def operational_abilities
      can(:manage, Truckload, user: @user)
      can(%i[read destroy], Cte, user: @user)
      can(:manage, Client, enterprise: @enterprise)
      can(:update, User, user: @user)
      can(:manage, Driver, enterprise: @enterprise)
      can(:manage, Agent, enterprise: @enterprise)
      can(%i[create destroy], TransferRequest, enterprise: @enterprise, user: @user)
      can(:read, TransferRequest, enterprise: @enterprise)
    end
  end
end
