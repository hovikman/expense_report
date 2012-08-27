# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
ExpenseReport::Application.initialize!

ExpenseReport::Application.configure do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "www.gmail.com",
    :authentication       => "plain",
    :user_name            => "hovikman@gmail.com",
    :password             => "hmhsr000",
    :enable_starttls_auto => true
  }
end    
