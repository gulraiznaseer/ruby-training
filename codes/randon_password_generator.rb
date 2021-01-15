require 'csv'
require 'byebug'

def validate_password_length(password_length)
  if password_length < 10
    @password_length = 10
  elsif password_length > 25
    @password_length = 25
  end
  @password_length
end

def take_input_from_user
  puts 'Please Provide the length for Password, Valid Range(10-25)'
  validate_password_length(@password_length = gets.to_i)

  puts 'Please Provide the percentage of integers in password'
  @int_percentage = gets.to_i

  puts 'Please Provide the percentage of alphabets in password'
  @alpha_percentage = gets.to_i

  puts 'Please Provide the percentage of symbols in password'
  @symbol_percentage = gets.to_i
end

def generate_password (password_length, int_percentage, alpha_percentage, symbol_percentage)
  [(Array.new((int_percentage * password_length) / 100) { rand(0..9) }).join + (Array.new((alpha_percentage * password_length) / 100) { rand(65..122).chr }).join + (Array.new((symbol_percentage * password_length) / 100) { rand(33..47).chr }).join ]
end

def save_passwod(password_value)
  CSV.open('file.csv', 'a+') do |row|
    row << password_value
  end
end

def check_identical_password(password_value)
  contents = CSV.open('file.csv')
  contents.each do |row|
    if password_value == row[0]
      return true
    end
  end
  false
end

take_input_from_user
password_value = generate_password(@password_length, @int_percentage, @alpha_percentage, @symbol_percentage)

check_identical_password(password_value) ? generate_password(@password_length, @int_percentage, @alpha_percentage, @symbol_percentage): save_passwod(password_value)
