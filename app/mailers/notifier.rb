class Notifier < ActionMailer::Base
  default from: 'Expense Report Application <hovikman@gmail.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.status_changed.subject
  #
  def status_changed(expense)
    @expense = expense
    mail to: @expense.user.email, subject: 'Expense Report Notification: The status of your expense has been changed'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.became_owner.subject
  #
  def became_owner(expense)
    @expense = expense
    mail to: @expense.owner.email, subject: 'Expense Report Notification: You became the owner of an expense'
  end
  
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Expense Report Notification: Password Reset"
  end
  
  def welcome(user)
    @user = user
    mail to: user.email, subject: "Expense Report Notification: Welcome!"
  end

end
