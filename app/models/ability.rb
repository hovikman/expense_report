class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new #guest user

    case
    when user.vendor_admin?
      can :manage, :all
    when user.regular_user?
      regular_user_permission(user)
    when user.company_admin?
      regular_user_permission(user)
      company_admin_permission(user)
    end
  end

private
  
  def regular_user_permission(user)
    # Company
    # no permission on Company

    # Currency
    # no permission on Currency

    # Expense
    can [:read, :update, :destroy], Expense, :user_id => user.id
    can :create, Expense

    # ExpenseDetail
    can [:read, :update, :destroy], ExpenseDetail, :expense => { :user_id => user.id }
    can :create, ExpenseDetail

    # ExpenseStatus
    # no permission on ExpenseStatus

    # ExpenseType
    can :read, ExpenseType, :company_id => user.company_id
    can :read, ExpenseType, :company_id => Company::vendor_id

    # User
    can [:read, :update], User, :id => user.id

    # UserType
    # no permission on UserType
  end

  def company_admin_permission(user)
    # ExpenseType
    can :create, ExpenseType
    can [:update, :destroy], ExpenseType, :company_id => user.company_id

    # User
    can :create, User
    can [:read, :update, :destroy], User, :company_id => user.company_id

    # Expense
    can [:read, :update, :destroy], Expense, :company_id => user.company_id
    
    # ExpenseDetail
    can [:read, :update, :destroy], ExpenseDetail, :company_id => user.company_id
  end

end
