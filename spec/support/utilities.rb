include ApplicationHelper

shared_examples_for "all static pages" do
  it { should have_selector('h1',    text: heading) }
  it { should have_title(full_title(page_title)) }
end

RSpec::Matchers::define :have_title do |text|
  match do |page|
    Capybara.string(page.body).has_selector?('title', text: text)
  end
end