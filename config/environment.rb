# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
ExpenseReport::Application.initialize!

ExpenseReport::Application.configure do
  config.action_mailer.raise_delivery_errors = true
end