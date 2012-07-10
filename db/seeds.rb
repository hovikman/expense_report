# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ExpenseDetail.delete_all
Expense.delete_all
User.delete_all
ExpenseType.delete_all
Company.delete_all
UserType.delete_all
ExpenseStatus.delete_all
Currency.delete_all

#Currency
Currency.create(:code => 'ARS', :name => 'Argentine Peso')
Currency.create(:code => 'AUD', :name => 'Australian Dollar')
Currency.create(:code => 'BRL', :name => 'Brazilian Real')
Currency.create(:code => 'GBP', :name => 'British Pound')
Currency.create(:code => 'CAD', :name => 'Canadian Dollar')
Currency.create(:code => 'CNY', :name => 'Chinese Yuan')
Currency.create(:code => 'EUR', :name => 'Euro')
Currency.create(:code => 'HKD', :name => 'Hong Kong Dollar')
Currency.create(:code => 'INR', :name => 'Indian Rupee')
Currency.create(:code => 'JPY', :name => 'Japanese Yen')
Currency.create(:code => 'KRW', :name => 'Korean Won')
Currency.create(:code => 'RUB', :name => 'Russian Rouble')
Currency.create(:code => 'USD', :name => 'U.S. Dollar')

#ExpenseStatus
ExpenseStatus.create(:name => ExpenseStatus::NOT_APPROVED_STR)
ExpenseStatus.create(:name => ExpenseStatus::APPROVED_STR)
ExpenseStatus.create(:name => ExpenseStatus::DECLINED_STR)

#UserType
UserType.create(:name => UserType::ADMIN_STR)
UserType.create(:name => UserType::REGULAR_USER_STR)
UserType.create(:name => UserType::VENDOR_ADMIN_STR)

#Company
Company.create(:name => Company::VENDOR_NAME_STR,
               :currency_id => Currency.find_by_code("USD").id,
               :contact_person => 'Hovik Manvelyan',
               :contact_title => 'Programmer',
               :contact_phone => '5105730246',
               :contact_email => 'hovikman@gmail.com'
              )
Company.create(:name => 'Company A',
               :currency_id => Currency.find_by_code("USD").id,
               :contact_person => 'Sam Ruby',
               :contact_title => 'Admin',
               :contact_phone => '4805790277',
               :contact_email => 'sam.ruby@companya.com'
              )
Company.create(:name => 'Company B',
               :currency_id => Currency.find_by_code("GBP").id,
               :contact_person => 'Dave Thomas',
               :contact_title => 'Admin',
               :contact_phone => '9105790943',
               :contact_email => 'dave.thomas@companyb.com'
              )

#ExpenseType
ExpenseType.create(:name => 'Airfare',
                   :company_id => Company::vendor_id
                  )
ExpenseType.create(:name => 'Lodging',
                   :company_id => Company::vendor_id
                  )
ExpenseType.create(:name => 'Ground Transportation',
                   :company_id => Company::vendor_id
                  )
ExpenseType.create(:name => 'Meal',
                   :company_id => Company::vendor_id
                  )
ExpenseType.create(:name => 'Conference and Seminar',
                   :company_id => Company::vendor_id
                  )
ExpenseType.create(:name => 'Miscellaneous',
                   :company_id => Company::vendor_id
                  )
ExpenseType.create(:name => 'Phone, Fax and Internet',
                   :company_id => Company::vendor_id
                  )
ExpenseType.create(:name => 'Entertainment',
                   :company_id => Company::vendor_id
                  )
ExpenseType.create(:name => 'Office Supply',
                   :company_id => Company::vendor_id
                  )
ExpenseType.create(:name => 'Postage and Shipping',
                   :company_id => Company::vendor_id
                  )
             
#User
User.create(:name => 'Hovik Manvelyan',
            :company_id => Company::vendor_id,
            :user_type_id => UserType::vendor_admin_id,
            :manager_id => nil,
            :email => 'hovikman@gmail.com',
            :password => 'foobar',
            :password_confirmation => 'foobar'
            )
User.create(:name => 'Sam Ruby',
            :company_id => Company.find_by_name("Company A").id,
            :user_type_id => UserType::admin_id,
            :manager_id => nil,
            :email => 'sam.ruby@companya.com',
            :password => 'foobar',
            :password_confirmation => 'foobar'
            )
User.create(:name => 'Dave Thomas',
            :company_id => Company.find_by_name("Company A").id,
            :user_type_id => UserType::regular_user_id,
            :manager_id => User.find_by_name("Sam Ruby").id,
            :email => 'dave.thomas@companya.com',
            :password => 'foobar',
            :password_confirmation => 'foobar'
            )
User.create(:name => 'David Hansson',
            :company_id => Company.find_by_name("Company B").id,
            :user_type_id => UserType::admin_id,
            :manager_id => nil,
            :email => 'david.hansson@companyb.com',
            :password => 'foobar',
            :password_confirmation => 'foobar'
            )
User.create(:name => 'Leon Breedt',
            :company_id => Company.find_by_name("Company B").id,
            :user_type_id => UserType::regular_user_id,
            :manager_id => User.find_by_name("David Hansson").id,
            :email => 'leon.breedt@companyb.com',
            :password => 'foobar',
            :password_confirmation => 'foobar'
            )
User.create(:name => 'admin',
            :company_id => Company.find_by_name("Company A").id,
            :user_type_id => UserType::admin_id,
            :manager_id => User.find_by_name("David Hansson").id,
            :email => 'admin@companya.com',
            :password => 'foobar',
            :password_confirmation => 'foobar'
            )
User.create(:name => 'vendor_admin',
            :company_id => Company.find_by_name(Company::VENDOR_NAME_STR).id,
            :user_type_id => UserType::vendor_admin_id,
            :manager_id => User.find_by_name("David Hansson").id,
            :email => 'vendor_admin@vendor_company.com',
            :password => 'foobar',
            :password_confirmation => 'foobar'
            )
User.create(:name => 'regular user',
            :company_id => Company.find_by_name("Company A").id,
            :user_type_id => UserType::regular_user_id,
            :manager_id => User.find_by_name("David Hansson").id,
            :email => 'regular_user@companya.com',
            :password => 'foobar',
            :password_confirmation => 'foobar'
            )


#Expense
Expense.create(:user_id => User.find_by_name("David Hansson").id,
               :purpose => "Expenses for my trip to Paris",
               :submit_date => Time.now,
               :advance_pay => 500.00,
               :expense_status_id => ExpenseStatus.not_approved_id
              ) 
Expense.create(:user_id => User.find_by_name("Leon Breedt").id,
               :purpose => "Expenses for my trip to New York",
               :submit_date => Time.now,
               :advance_pay => 0.00,
               :expense_status_id => ExpenseStatus.not_approved_id
              ) 
Expense.create(:user_id => User.find_by_name("Sam Ruby").id,
               :purpose => "Expenses for my trip to Tokio",
               :submit_date => Time.now,
               :advance_pay => 0.00,
               :expense_status_id => ExpenseStatus.not_approved_id
              )
Expense.create(:user_id => User.find_by_name("admin").id,
               :purpose => "Expenses for my trip to Tokio",
               :submit_date => Time.now,
               :advance_pay => 10.00,
               :expense_status_id => ExpenseStatus.not_approved_id
              )
Expense.create(:user_id => User.find_by_name("regular user").id,
               :purpose => "Expenses for my trip to Tokio",
               :submit_date => Time.now,
               :advance_pay => 10.00,
               :expense_status_id => ExpenseStatus.not_approved_id
              )

#ExpenseDetail
ExpenseDetail.create(:expense_id => Expense.find_by_user_id(User.find_by_name("David Hansson").id).id,
                     :expense_type_id => ExpenseType.find_by_name('Meal').id,
                     :date => Time.now,
                     :amount => 40.00,
                     :currency_id => Currency.find_by_code("USD").id,
                     :exchange_rate => 1.00,
                     :comments => 'New York is very expensive city'
                    )
ExpenseDetail.create(:expense_id => Expense.find_by_user_id(User.find_by_name("Leon Breedt").id).id,
                     :expense_type_id => ExpenseType.find_by_name('Entertainment').id,
                     :date => Time.now,
                     :amount => 240.00,
                     :currency_id => Currency.find_by_code("USD").id,
                     :exchange_rate => 1.00,
                     :comments => 'I had a great time'
                    )
ExpenseDetail.create(:expense_id => Expense.find_by_user_id(User.find_by_name("Sam Ruby").id).id,
                     :expense_type_id => ExpenseType.find_by_name('Airfare').id,
                     :date => Time.now,
                     :amount => 1040.00,
                     :currency_id => Currency.find_by_code("USD").id,
                     :exchange_rate => 1.00,
                     :comments => 'I used United Airlines'
                    )
ExpenseDetail.create(:expense_id => Expense.find_by_user_id(User.find_by_name("David Hansson").id).id,
                     :expense_type_id => ExpenseType.find_by_name('Office Supply').id,
                     :date => Time.now,
                     :amount => 30.00,
                     :currency_id => Currency.find_by_code("USD").id,
                     :exchange_rate => 1.00,
                     :comments => 'I needed some pens'
                    )
ExpenseDetail.create(:expense_id => Expense.find_by_user_id(User.find_by_name("admin").id).id,
                     :expense_type_id => ExpenseType.find_by_name('Office Supply').id,
                     :date => Time.now,
                     :amount => 30.00,
                     :currency_id => Currency.find_by_code("JPY").id,
                     :exchange_rate => 1.00,
                     :comments => 'I needed some pens'
                    )
ExpenseDetail.create(:expense_id => Expense.find_by_user_id(User.find_by_name("regular user").id).id,
                     :expense_type_id => ExpenseType.find_by_name('Office Supply').id,
                     :date => Time.now,
                     :amount => 30.00,
                     :currency_id => Currency.find_by_code("RUB").id,
                     :exchange_rate => 1.00,
                     :comments => 'I needed some pens'
                    )
