class Ability
  include CanCan::Ability

  def initialize(user, controller_namespace)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.editor?
      can :manage, :all
      cannot :manage, User
      can :update, User, id: user.id
    else
      if controller_namespace == "Admin"
        cannot :manage, :all
      else
        can :manage, :all
        cannot :read, Invoice
        can :read, Invoice, customer: user
      end
    end
  end
end
