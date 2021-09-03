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
      when :financial
        financial_abilities
      when :monitoring
        monitoring_abilities
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
      can(%i[manage approve reject], TransferRequest, enterprise: @enterprise)
    end

    def operational_abilities
      can(%i[read create], Truckload, enterprise: @enterprise)
      can(%i[update destroy], Truckload, user: @user, enterprise: @enterprise)
      can(:read, Cte, enterprise: @enterprise)
      can(%i[destroy], Cte, truckload: [user: @user], enterprise: @enterprise)
      can(:manage, Client, enterprise: @enterprise)
      can(:update, User, id: @user.id)
      can(:manage, Driver, enterprise: @enterprise)
      can(:manage, Agent, enterprise: @enterprise)
      can(%i[create cancel], TransferRequest, user: @user, enterprise: @enterprise)
      can(:read, TransferRequest, enterprise: @enterprise)
      can(:create, Comment)
    end

    def financial_abilities
      can(%i[update read read_pending approve reject], TransferRequest, enterprise: @enterprise)
      can(:read, Truckload, enterprise: @enterprise)
      can(:read, Cte, enterprise: @enterprise)
      can(:read, Driver, enterprise: @enterprise)
      can(:read, Agent, enterprise: @enterprise)
    end

    def monitoring_abilities
      can(:read, Cte, enterprise: @enterprise)
      can(:read, Driver, enterprise: @enterprise)
      can(:read, Client, enterprise: @enterprise)
      can(:read, Truckload, enterprise: @enterprise)
      can(:create, Comment)
    end
  end
end
