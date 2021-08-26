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
    end

    def operational_abilities
      can(%i[read create], Truckload, enterprise: @enterprise)
      can(%i[update destroy], Truckload, user: @user)
      can(:read, Cte, enterprise: @enterprise)
      can(%i[destroy], Cte, truckload: [user: @user])
      can(:manage, Client, enterprise: @enterprise)
      can(:update, User, id: @user.id)
      can(:manage, Driver, enterprise: @enterprise)
      can(:manage, Agent, enterprise: @enterprise)
      can(%i[create cancel], TransferRequest, enterprise: @enterprise, user: @user)
      can(:read, TransferRequest, enterprise: @enterprise)
    end
  end
end
