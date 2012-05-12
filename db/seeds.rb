# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#UserType.delete_all
#ExpenseStatus.delete_all
#Company.delete_all
Currency.delete_all

#UserType
#UserType.create(:name => 'Vendor Administrator')
#UserType.create(:name => 'Administrator')
#UserType.create(:name => 'Regular User')

#ExpenseStatus
#ExpenseStatus.create(:name => 'Not Approved')
#ExpenseStatus.create(:name => 'Approved')
#ExpenseStatus.create(:name => 'Declined')

#Currency
#Currency.create(:code => 'ARS', :name => 'Argentine Peso')
#Currency.create(:code => 'AUD', :name => 'Australian Dollar')
#Currency.create(:code => 'BRL', :name => 'Brazilian Real')
#Currency.create(:code => 'GBP', :name => 'British Pound')
#Currency.create(:code => 'CAD', :name => 'Canadian Dollar')
#Currency.create(:code => 'CNY', :name => 'Chinese Yuan')
#Currency.create(:code => 'EUR', :name => 'Euro')
#Currency.create(:code => 'HKD', :name => 'Hong Kong Dollar')
#Currency.create(:code => 'INR', :name => 'Indian Rupee')
#Currency.create(:code => 'JPY', :name => 'Japanese Yen')
#Currency.create(:code => 'USD', :name => 'U.S. Dollar')
#Currency.create(:code => 'KRW', :name => 'Korean Won')
#Currency.create(:code => 'RUB', :name => 'Russian Rouble')

#Company
#Company.create(:name => 'Vendor',
#              :tag => 'vendor',
#              :currency_id => Currency.find_by_code("USD").id,
#              :contact_person => 'Hovik Manvelyan',
#              :contact_title => 'Programmer',
#              :contact_phone => '5105730246',
#              :contact_email => 'hovikman@gmail.com'
#             )

