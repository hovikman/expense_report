STDIN.each do |str|
  currency = str.chomp!.split(' ', 2)
  puts "Currency.create(:code => \'#{currency[0]}\', :name => \'#{currency[1]}\')"
end    
 




