class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.has_role?(:admin)
    can :access, :rails_admin
    can :manage, :all
  end
end
