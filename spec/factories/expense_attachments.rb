include ActionDispatch::TestProcess

FactoryGirl.define do

  factory :expense_attachment do
    description 'Sample Description'
    expense
    file_path   { fixture_file_upload(Rails.root.join('spec', 'support', 'test_files', 'burney_falls.jpg'), 'image/jpg') }
  end

end