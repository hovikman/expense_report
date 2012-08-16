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
    can [:create], Expense
    can [:transition, :submitted], Expense, :user_id => user.id 

    # if the owner of expense, can't figure out how to make it work
    can [:transition, :owned, :change_state], Expense
    
=begin
    can [:transition, :owned, :change_state], Expense do |expense|
      expense.user_id == expense.user_id
      if expense.expense_status_id == ExpenseStatus.new_id
        user_id == user.id
      elsif expense.expense_status_id == ExpenseStatus.assigned_to_manager_id
        expense.user.manager_id == user.id
      elsif expense.expense_status_id == ExpenseStatus.assigned_to_accounting_id
        expense.user.company.accountant_id == user.id
      end
    end

    can [:transition, :owned, :change_state], Expense do |expense|
      true
    end
=end
      
        
    # ExpenseDetail
    can [:read, :update, :destroy], ExpenseDetail, :expense => { :user_id => user.id }
    can :create, ExpenseDetail
    
    # ExpenseStatus
    # no permission on ExpenseStatus

    # ExpenseType
    can :read, ExpenseType, :company_id => user.company_id
    can :read, ExpenseType, :company_id => Company::vendor_id

    # User
    can [:update], User, :id => user.id
    can [:read], User, :company_id => user.company_id

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
    can [:read, :update, :destroy], Expense, :user => { :company_id => user.company_id }
    
    # ExpenseDetail
    can [:read, :update, :destroy], ExpenseDetail, :expense => { :user => { :company_id => user.company_id } }
  end

end
