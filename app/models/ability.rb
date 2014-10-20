class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
      can :access, :rails_admin   # grant access to rails_admin
    else
      # can :read, :all
      unless user.new_record?
        can :create, [Visit, Token, TokenHistory, Patient, Physician, Test, TestGroup]

        can :update, Visit do |visit|
          user.current_location == visit.location
        end

        can [:done, :discard, :update], Token do |token|
          user.current_location == token.location
        end

        can :update, [Patient, Physician, Test, TestGroup]
      end
    end
  end
end
