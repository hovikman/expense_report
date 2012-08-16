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
Currency.create(:code => 'AED', :name => 'United Arab Emirates Dirham')
Currency.create(:code => 'AFN', :name => 'Afghanistan Afghani')
Currency.create(:code => 'ALL', :name => 'Albania Lek')
Currency.create(:code => 'AMD', :name => 'Armenia Dram')
Currency.create(:code => 'ANG', :name => 'Netherlands Antilles Guilder')
Currency.create(:code => 'AOA', :name => 'Angola Kwanza')
Currency.create(:code => 'ARS', :name => 'Argentina Peso')
Currency.create(:code => 'AUD', :name => 'Australia Dollar')
Currency.create(:code => 'AWG', :name => 'Aruba Guilder')
Currency.create(:code => 'AZN', :name => 'Azerbaijan New Manat')
Currency.create(:code => 'BAM', :name => 'Bosnia and Herzegovina Convertible Marka')
Currency.create(:code => 'BBD', :name => 'Barbados Dollar')
Currency.create(:code => 'BDT', :name => 'Bangladesh Taka')
Currency.create(:code => 'BGN', :name => 'Bulgaria Lev')
Currency.create(:code => 'BHD', :name => 'Bahrain Dinar')
Currency.create(:code => 'BIF', :name => 'Burundi Franc')
Currency.create(:code => 'BMD', :name => 'Bermuda Dollar')
Currency.create(:code => 'BND', :name => 'Brunei Darussalam Dollar')
Currency.create(:code => 'BOB', :name => 'Bolivia Boliviano')
Currency.create(:code => 'BRL', :name => 'Brazil Real')
Currency.create(:code => 'BSD', :name => 'Bahamas Dollar')
Currency.create(:code => 'BTN', :name => 'Bhutan Ngultrum')
Currency.create(:code => 'BWP', :name => 'Botswana Pula')
Currency.create(:code => 'BYR', :name => 'Belarus Ruble')
Currency.create(:code => 'BZD', :name => 'Belize Dollar')
Currency.create(:code => 'CAD', :name => 'Canada Dollar')
Currency.create(:code => 'CDF', :name => 'Congo/Kinshasa Franc')
Currency.create(:code => 'CHF', :name => 'Switzerland Franc')
Currency.create(:code => 'CLP', :name => 'Chile Peso')
Currency.create(:code => 'CNY', :name => 'China Yuan Renminbi')
Currency.create(:code => 'COP', :name => 'Colombia Peso')
Currency.create(:code => 'CRC', :name => 'Costa Rica Colon')
Currency.create(:code => 'CUC', :name => 'Cuba Convertible Peso')
Currency.create(:code => 'CUP', :name => 'Cuba Peso')
Currency.create(:code => 'CVE', :name => 'Cape Verde Escudo')
Currency.create(:code => 'CZK', :name => 'Czech Republic Koruna')
Currency.create(:code => 'DJF', :name => 'Djibouti Franc')
Currency.create(:code => 'DKK', :name => 'Denmark Krone')
Currency.create(:code => 'DOP', :name => 'Dominican Republic Peso')
Currency.create(:code => 'DZD', :name => 'Algeria Dinar')
Currency.create(:code => 'EGP', :name => 'Egypt Pound')
Currency.create(:code => 'ERN', :name => 'Eritrea Nakfa')
Currency.create(:code => 'ETB', :name => 'Ethiopia Birr')
Currency.create(:code => 'EUR', :name => 'Euro Member Countries')
Currency.create(:code => 'FJD', :name => 'Fiji Dollar')
Currency.create(:code => 'FKP', :name => 'Falkland Islands (Malvinas) Pound')
Currency.create(:code => 'GBP', :name => 'United Kingdom Pound')
Currency.create(:code => 'GEL', :name => 'Georgia Lari')
Currency.create(:code => 'GGP', :name => 'Guernsey Pound')
Currency.create(:code => 'GHS', :name => 'Ghana Cedi')
Currency.create(:code => 'GIP', :name => 'Gibraltar Pound')
Currency.create(:code => 'GMD', :name => 'Gambia Dalasi')
Currency.create(:code => 'GNF', :name => 'Guinea Franc')
Currency.create(:code => 'GTQ', :name => 'Guatemala Quetzal')
Currency.create(:code => 'GYD', :name => 'Guyana Dollar')
Currency.create(:code => 'HKD', :name => 'Hong Kong Dollar')
Currency.create(:code => 'HNL', :name => 'Honduras Lempira')
Currency.create(:code => 'HRK', :name => 'Croatia Kuna')
Currency.create(:code => 'HTG', :name => 'Haiti Gourde')
Currency.create(:code => 'HUF', :name => 'Hungary Forint')
Currency.create(:code => 'IDR', :name => 'Indonesia Rupiah')
Currency.create(:code => 'ILS', :name => 'Israel Shekel')
Currency.create(:code => 'IMP', :name => 'Isle of Man Pound')
Currency.create(:code => 'INR', :name => 'India Rupee')
Currency.create(:code => 'IQD', :name => 'Iraq Dinar')
Currency.create(:code => 'IRR', :name => 'Iran Rial')
Currency.create(:code => 'ISK', :name => 'Iceland Krona')
Currency.create(:code => 'JEP', :name => 'Jersey Pound')
Currency.create(:code => 'JMD', :name => 'Jamaica Dollar')
Currency.create(:code => 'JOD', :name => 'Jordan Dinar')
Currency.create(:code => 'JPY', :name => 'Japan Yen')
Currency.create(:code => 'KES', :name => 'Kenya Shilling')
Currency.create(:code => 'KGS', :name => 'Kyrgyzstan Som')
Currency.create(:code => 'KHR', :name => 'Cambodia Riel')
Currency.create(:code => 'KMF', :name => 'Comoros Franc')
Currency.create(:code => 'KPW', :name => 'Korea (North) Won')
Currency.create(:code => 'KRW', :name => 'Korea (South) Won')
Currency.create(:code => 'KWD', :name => 'Kuwait Dinar')
Currency.create(:code => 'KYD', :name => 'Cayman Islands Dollar')
Currency.create(:code => 'KZT', :name => 'Kazakhstan Tenge')
Currency.create(:code => 'LAK', :name => 'Laos Kip')
Currency.create(:code => 'LBP', :name => 'Lebanon Pound')
Currency.create(:code => 'LKR', :name => 'Sri Lanka Rupee')
Currency.create(:code => 'LRD', :name => 'Liberia Dollar')
Currency.create(:code => 'LSL', :name => 'Lesotho Loti')
Currency.create(:code => 'LTL', :name => 'Lithuania Litas')
Currency.create(:code => 'LVL', :name => 'Latvia Lat')
Currency.create(:code => 'LYD', :name => 'Libya Dinar')
Currency.create(:code => 'MAD', :name => 'Morocco Dirham')
Currency.create(:code => 'MDL', :name => 'Moldova Leu')
Currency.create(:code => 'MGA', :name => 'Madagascar Ariary')
Currency.create(:code => 'MKD', :name => 'Macedonia Denar')
Currency.create(:code => 'MMK', :name => 'Myanmar (Burma) Kyat')
Currency.create(:code => 'MNT', :name => 'Mongolia Tughrik')
Currency.create(:code => 'MOP', :name => 'Macau Pataca')
Currency.create(:code => 'MRO', :name => 'Mauritania Ouguiya')
Currency.create(:code => 'MUR', :name => 'Mauritius Rupee')
Currency.create(:code => 'MVR', :name => 'Maldives (Maldive Islands) Rufiyaa')
Currency.create(:code => 'MWK', :name => 'Malawi Kwacha')
Currency.create(:code => 'MXN', :name => 'Mexico Peso')
Currency.create(:code => 'MYR', :name => 'Malaysia Ringgit')
Currency.create(:code => 'MZN', :name => 'Mozambique Metical')
Currency.create(:code => 'NAD', :name => 'Namibia Dollar')
Currency.create(:code => 'NGN', :name => 'Nigeria Naira')
Currency.create(:code => 'NIO', :name => 'Nicaragua Cordoba')
Currency.create(:code => 'NOK', :name => 'Norway Krone')
Currency.create(:code => 'NPR', :name => 'Nepal Rupee')
Currency.create(:code => 'NZD', :name => 'New Zealand Dollar')
Currency.create(:code => 'OMR', :name => 'Oman Rial')
Currency.create(:code => 'PAB', :name => 'Panama Balboa')
Currency.create(:code => 'PEN', :name => 'Peru Nuevo Sol')
Currency.create(:code => 'PGK', :name => 'Papua New Guinea Kina')
Currency.create(:code => 'PHP', :name => 'Philippines Peso')
Currency.create(:code => 'PKR', :name => 'Pakistan Rupee')
Currency.create(:code => 'PLN', :name => 'Poland Zloty')
Currency.create(:code => 'PYG', :name => 'Paraguay Guarani')
Currency.create(:code => 'QAR', :name => 'Qatar Riyal')
Currency.create(:code => 'RON', :name => 'Romania New Leu')
Currency.create(:code => 'RSD', :name => 'Serbia Dinar')
Currency.create(:code => 'RUB', :name => 'Russia Ruble')
Currency.create(:code => 'RWF', :name => 'Rwanda Franc')
Currency.create(:code => 'SAR', :name => 'Saudi Arabia Riyal')
Currency.create(:code => 'SBD', :name => 'Solomon Islands Dollar')
Currency.create(:code => 'SCR', :name => 'Seychelles Rupee')
Currency.create(:code => 'SDG', :name => 'Sudan Pound')
Currency.create(:code => 'SEK', :name => 'Sweden Krona')
Currency.create(:code => 'SGD', :name => 'Singapore Dollar')
Currency.create(:code => 'SHP', :name => 'Saint Helena Pound')
Currency.create(:code => 'SLL', :name => 'Sierra Leone Leone')
Currency.create(:code => 'SOS', :name => 'Somalia Shilling')
Currency.create(:code => 'SPL', :name => 'Seborga Luigino')
Currency.create(:code => 'SRD', :name => 'Suriname Dollar')
Currency.create(:code => 'STD', :name => 'Sao Tome and Principe Dobra')
Currency.create(:code => 'SVC', :name => 'El Salvador Colon')
Currency.create(:code => 'SYP', :name => 'Syria Pound')
Currency.create(:code => 'SZL', :name => 'Swaziland Lilangeni')
Currency.create(:code => 'THB', :name => 'Thailand Baht')
Currency.create(:code => 'TJS', :name => 'Tajikistan Somoni')
Currency.create(:code => 'TMT', :name => 'Turkmenistan Manat')
Currency.create(:code => 'TND', :name => 'Tunisia Dinar')
Currency.create(:code => 'TOP', :name => 'Tonga Pa\'anga')
Currency.create(:code => 'TRY', :name => 'Turkey Lira')
Currency.create(:code => 'TTD', :name => 'Trinidad and Tobago Dollar')
Currency.create(:code => 'TVD', :name => 'Tuvalu Dollar')
Currency.create(:code => 'TWD', :name => 'Taiwan New Dollar')
Currency.create(:code => 'TZS', :name => 'Tanzania Shilling')
Currency.create(:code => 'UAH', :name => 'Ukraine Hryvna')
Currency.create(:code => 'UGX', :name => 'Uganda Shilling')
Currency.create(:code => 'USD', :name => 'United States Dollar')
Currency.create(:code => 'UYU', :name => 'Uruguay Peso')
Currency.create(:code => 'UZS', :name => 'Uzbekistan Som')
Currency.create(:code => 'VEF', :name => 'Venezuela Bolivar Fuerte')
Currency.create(:code => 'VND', :name => 'Viet Nam Dong')
Currency.create(:code => 'VUV', :name => 'Vanuatu Vatu')
Currency.create(:code => 'WST', :name => 'Samoa Tala')
Currency.create(:code => 'XCD', :name => 'East Caribbean Dollar')
Currency.create(:code => 'YER', :name => 'Yemen Rial')
Currency.create(:code => 'ZAR', :name => 'South Africa Rand')
Currency.create(:code => 'ZMK', :name => 'Zambia Kwacha')
Currency.create(:code => 'ZWD', :name => 'Zimbabwe Dollar')

#ExpenseStatus
ExpenseStatus.create(:name => ExpenseStatus::NEW_STR)
ExpenseStatus.create(:name => ExpenseStatus::ASSIGNED_TO_MANAGER_STR)
ExpenseStatus.create(:name => ExpenseStatus::ASSIGNED_TO_ACCOUNTING_STR)
ExpenseStatus.create(:name => ExpenseStatus::APPROVED_STR)

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
               :contact_email => 'hovikman@gmail.com',
              )
Company.create(:name => 'Company A',
               :currency_id => Currency.find_by_code("USD").id,
               :contact_person => 'Sam Ruby',
               :contact_title => 'Admin',
               :contact_phone => '4805790277',
               :contact_email => 'sam.ruby@companya.com',
              )
Company.create(:name => 'Company B',
               :currency_id => Currency.find_by_code("GBP").id,
               :contact_person => 'Dave Thomas',
               :contact_title => 'Admin',
               :contact_phone => '9105790943',
               :contact_email => 'dave.thomas@companyb.com',
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
ExpenseType.create(:name => 'Company A1',
                   :company_id => Company.find_by_name('Company A').id
                  )
ExpenseType.create(:name => 'Company A2',
                   :company_id => Company.find_by_name('Company A').id
                  )
ExpenseType.create(:name => 'Company B1',
                   :company_id => Company.find_by_name('Company B').id
                  )
ExpenseType.create(:name => 'Company B2',
                   :company_id => Company.find_by_name('Company B').id
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
            :manager_id => nil,
            :email => 'admin@companya.com',
            :password => 'foobar',
            :password_confirmation => 'foobar'
            )
User.create(:name => 'vendor_admin',
            :company_id => Company.find_by_name(Company::VENDOR_NAME_STR).id,
            :user_type_id => UserType::vendor_admin_id,
            :manager_id => nil,
            :email => 'vendor_admin@vendor_company.com',
            :password => 'foobar',
            :password_confirmation => 'foobar'
            )
User.create(:name => 'regular user',
            :company_id => Company.find_by_name("Company A").id,
            :user_type_id => UserType::regular_user_id,
            :manager_id => User.find_by_name("admin").id,
            :email => 'regular_user@companya.com',
            :password => 'foobar',
            :password_confirmation => 'foobar'
            )

#Expense
Expense.create(:user_id => User.find_by_name("David Hansson").id,
               :purpose => "Expenses for my trip to Paris",
               :advance_pay => 500.00,
               :expense_status_id => ExpenseStatus.new_id
              ) 
Expense.create(:user_id => User.find_by_name("Leon Breedt").id,
               :purpose => "Expenses for my trip to New York",
               :advance_pay => 0.00,
               :expense_status_id => ExpenseStatus.assigned_to_manager_id
              ) 
Expense.create(:user_id => User.find_by_name("Sam Ruby").id,
               :purpose => "Expenses for my trip to Tokio",
               :advance_pay => 0.00,
               :expense_status_id => ExpenseStatus.assigned_to_manager_id
              )
Expense.create(:user_id => User.find_by_name("admin").id,
               :purpose => "Expenses for my trip to London",
               :advance_pay => 10.00,
               :expense_status_id => ExpenseStatus.assigned_to_accounting_id
              )
Expense.create(:user_id => User.find_by_name("regular user").id,
               :purpose => "Expenses for my trip to Moscow",
               :advance_pay => 10.00,
               :expense_status_id => ExpenseStatus.assigned_to_manager_id
              )
Expense.create(:user_id => User.find_by_name("Leon Breedt").id,
               :purpose => "Expenses for my trip",
               :advance_pay => 0.00,
               :expense_status_id => ExpenseStatus.assigned_to_manager_id
              )
              
#ExpenseDetail
ExpenseDetail.create(:expense_id => Expense.find_by_user_id(User.find_by_name("David Hansson").id).id,
                     :expense_type_id => ExpenseType.find_by_name('Meal').id,
                     :amount => 40.00,
                     :currency_id => Currency.find_by_code("USD").id,
                     :exchange_rate => 1.00,
                     :comments => 'New York is very expensive city'
                    )
ExpenseDetail.create(:expense_id => Expense.find_by_user_id(User.find_by_name("Leon Breedt").id).id,
                     :expense_type_id => ExpenseType.find_by_name('Entertainment').id,
                     :amount => 240.00,
                     :currency_id => Currency.find_by_code("USD").id,
                     :exchange_rate => 1.00,
                     :comments => 'I had a great time'
                    )
ExpenseDetail.create(:expense_id => Expense.find_by_user_id(User.find_by_name("Sam Ruby").id).id,
                     :expense_type_id => ExpenseType.find_by_name('Airfare').id,
                     :amount => 1040.00,
                     :currency_id => Currency.find_by_code("USD").id,
                     :exchange_rate => 1.00,
                     :comments => 'I used United Airlines'
                    )
ExpenseDetail.create(:expense_id => Expense.find_by_user_id(User.find_by_name("David Hansson").id).id,
                     :expense_type_id => ExpenseType.find_by_name('Office Supply').id,
                     :amount => 30.00,
                     :currency_id => Currency.find_by_code("USD").id,
                     :exchange_rate => 1.00,
                     :comments => 'I needed some pens'
                    )
ExpenseDetail.create(:expense_id => Expense.find_by_user_id(User.find_by_name("admin").id).id,
                     :expense_type_id => ExpenseType.find_by_name('Office Supply').id,
                     :amount => 30.00,
                     :currency_id => Currency.find_by_code("JPY").id,
                     :exchange_rate => 1.00,
                     :comments => 'I needed some pens'
                    )
ExpenseDetail.create(:expense_id => Expense.find_by_user_id(User.find_by_name("regular user").id).id,
                     :expense_type_id => ExpenseType.find_by_name('Office Supply').id,
                     :amount => 30.00,
                     :currency_id => Currency.find_by_code("RUB").id,
                     :exchange_rate => 1.00,
                     :comments => 'I needed some pens'
                    )
                    
company = Company.find_by_name(Company::VENDOR_NAME_STR)
company.accountant_id = User.find_by_name("admin").id
company.save

company = Company.find_by_name('Company A')
company.accountant_id = User.find_by_name("Sam Ruby").id
company.save

company = Company.find_by_name('Company B')
company.accountant_id = User.find_by_name("David Hansson").id
company.save