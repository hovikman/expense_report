class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new #guest user

    case
    when user.regular_user?
      regular_user_permission(user)
    when user.company_admin?
      company_admin_permission(user)
    when user.vendor_admin?
      vendor_admin_permission(user)
    end
  end

private

  def regular_user_permission(user)
    # Company
    # no permission on Company

    # Currency
    can :get_exchange_rate, Currency

    # Expense
    can [:create, :transition_buttons], Expense
    can [:read, :submitted], Expense, user_id: user.id 
    can :read, Expense, owner_id: user.id 
    can [:update, :destroy], Expense, user_id: user.id, owner_id: user.id
    can [:owned, :change_state], Expense, owner_id: user.id
        
    # ExpenseDetail
    can :create, ExpenseDetail
    can [:update, :destroy], ExpenseDetail, expense: {user_id: user.id, owner_id: user.id}
    can :read, ExpenseDetail, expense: {user_id: user.id}
    can :read, ExpenseDetail, expense: {owner_id: user.id}
    
    # ExpenseAttachment
    can :create, ExpenseAttachment
    can [:update, :destroy], ExpenseAttachment, expense: {user_id: user.id, owner_id: user.id}
    can :read, ExpenseAttachment, expense: {user_id: user.id}
    can :read, ExpenseAttachment, expense: {owner_id: user.id}

    # ExpenseStatus
    # no permission on ExpenseStatus

    # ExpenseType
    can :read, ExpenseType, company_id: user.company_id
    can :read, ExpenseType, company_id: Company::vendor_id

    # User
    can [:update], User, id: user.id
    can [:read], User, company_id: user.company_id

    # UserType
    # no permission on UserType
  end

  def company_admin_permission(user)
    # grant regular user permissions to company admin 
    regular_user_permission(user)

    # ExpenseType
    can [:create, :update, :destroy], ExpenseType, company_id: user.company_id

    # User
    can [:create, :read, :update, :destroy], User, company_id: user.company_id

    # Expense
    can [:read, :update, :destroy], Expense, user: {company_id: user.company_id}
    
    # ExpenseDetail
    can [:create, :read, :update, :destroy], ExpenseDetail, expense: {user: {company_id: user.company_id}}
    
    # ExpenseAttachment
    can [:create, :read, :update, :destroy], ExpenseAttachment, expense: {user: {company_id: user.company_id}}

    # ReplaceExpenseOwner
    can :create, ReplaceExpenseOwner
    
    # ReplaceUserManager
    can :create, ReplaceUserManager
  end

  def vendor_admin_permission(user)
    # grant company admin permissions to vendor admin 
    company_admin_permission(user)

    can :manage, Company
    can :manage, Currency
    can [:read, :update, :destroy], Expense
    can [:create, :read, :update, :destroy], ExpenseDetail
    can [:create, :read, :update, :destroy], ExpenseAttachment
    can :read, ExpenseStatus
    can :manage, ExpenseType
    can :manage, User
    can :read, UserType
  end

end
