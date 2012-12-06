require 'spec_helper'

describe "SessioinPages" do
  subject { page }
  
  describe "Sign in page" do
    before { visit signin_path }
    
    it { should have_selector('h1', text: "Sign in") }
    it { should have_selector('title', text: full_title("Sign in")) }
  end

end