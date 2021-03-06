class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :manager
      can :manage, User do |user|
        user.has_role?(:deliver) || user.has_role?(:user)
      end
      can :show, User do |user|
        user.has_role?(:manager) 
      end
    end
  end
end