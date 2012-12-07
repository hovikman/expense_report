require 'spec_helper'

describe User do

  before { @user = User.new(name: "Example User", email: "user@example.com") }

  subject { @user }

  # test accessable attributes
  it { should respond_to(:company_id) }
  it { should respond_to(:email) }
  it { should respond_to(:id) }
  it { should respond_to(:manager_id) }
  it { should respond_to(:name) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password_reset_sent_at) }
  it { should respond_to(:password_reset_token) }
  it { should respond_to(:phone) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:user_type_id) }
end